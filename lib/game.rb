require 'set'

class Game
  def initialize(word_list)
      @game_state = {
      word: word_list.sample,
      letters_guessed: Set.new(['a', 'b', 'c']),
      guesses: 0
    }
  end

  def display_word
    word = @game_state[:word]
    word_hidden = Array.new(word.length, '_')

    word_hidden.each_with_index do |char, index|
      word_hidden[index] = word[index] if @game_state[:letters_guessed].include?(word[index])
    end

    puts "the word is #{word}"
    puts "the hidden word is #{word_hidden}"
  end
end