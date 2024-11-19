require 'json'
require_relative 'hangman'

class Game
  def initialize(word_list)
      @game_state = {
      word: word_list.sample,
      letters_guessed: Array.new,
      guesses: 0
    }
  end

  def display_word
    word = @game_state[:word]
    word_hidden = Array.new(word.length, '_')

    word_hidden.each_with_index do |char, index|
      word_hidden[index] = word[index] if @game_state[:letters_guessed].include?(word[index])
    end

    puts word_hidden.join
  end

  def get_guess
    puts "Guess another letter!"
    input = gets.downcase.chomp

    until input.length == 1 && input =~ /[a-z]/
      puts "Your guess must be one letter"
      input = gets.downcase.chomp
    end

    while @game_state[:letters_guessed].include?(input)
      puts "You already guessed that letter"
      input = gets.downcase.chomp
    end

    input
  end

  def update_game(guess)
    @game_state[:letters_guessed] << guess
    @game_state[:guesses] += 1
  end

  def check_for_win
    @game_state[:word].chars.all? { |char| @game_state[:letters_guessed].include?(char)}
  end

  def game_won
    puts "You win! The word was #{@game_state[:word]}"
  end

  def game_lost
    puts "You lose. You'll never figure out what the word was"
  end

  def play_round
    puts "Letters guessed: #{@game_state[:letters_guessed].sort.join}"
    puts Hangman::HANGMANPICS[@game_state[:guesses]]
    return game_lost if @game_state[:guesses] >= 6

    display_word
    update_game(get_guess)

    check_for_win ? game_won : play_round
  end
end