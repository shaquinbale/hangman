require_relative 'game'

word_list = File.readlines('word_list.txt').map(&:chomp)
game = Game.new(word_list)

puts Hangman::HANGMANPICS[0]