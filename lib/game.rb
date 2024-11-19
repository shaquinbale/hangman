require 'set'

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

    input
  end
end