require 'set'
require_relative 'hangman'

class Game
  def initialize(word_list)
      @game_state = {
      word: word_list.sample,
      letters_guessed: Set.new,
      guesses: 0
    }
  end

  def display_word
    word = @game_state[:word]
    word_hidden = Array.new(word.length, '_')

    word_hidden.each_with_index do |char, index|
      word_hidden[index] = word[index] if @game_state[:letters_guessed].include?(word[index])
    end

    puts word_hidden
  end

  def get_guess
    puts "Guess another letter!"
    input = gets.downcase.chomp

    until input.length == 1 && input =~ [/a-z/]
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
    @game_state[letters_guessed].add guess
  end

  def game_won?
    
  end

  def end_game
    
  end

  def play_round
    puts Hangman::HANGMANPICS[@game_state[:guesses]]
    display_word
    update_game(get_guess)
    game_won? ? end_game : play_round
  end
end