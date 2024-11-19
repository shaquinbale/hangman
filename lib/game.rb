require 'json'
require_relative 'hangman'

class Game
  def initialize(word_list)
      @game_state = {
      "word" => word_list.sample,
      "letters_guessed" => Array.new,
      "guesses" => 0
    }
  end

  def start_game
    puts "HANGMAN"
    puts "1) New game"
    puts "2) Load game"
    puts "3) Quit game"

    menu_choice = gets.chomp
    until menu_choice =~ /^[1-3]$/
      puts "Please choose a valid option"
      menu_choice = gets.chomp
    end

    case menu_choice
    when "1"
      play_round
    when "2"
      load_to_file
      play_round
    when "3"
      puts "Exiting game, goodbye!"
      return
    end
  end

  def save_to_file(filename='save_game.json')
    File.write(filename, JSON.generate(@game_state))
  end

  def load_to_file(filename='save_game.json')
    if File.exist?(filename)
      data = JSON.parse(File.read(filename))
      p data["letters_guessed"]
      p data.values
      @game_state = data
    else
      puts "No save file found. Starting new game \n\n"
    end
    
  end

  def display_word
    word = @game_state["word"]
    word_hidden = Array.new(word.length, '_')

    word_hidden = word.chars.map.with_index do |char, index|
      @game_state["letters_guessed"].include?(char) ? char : '_'
    end

    puts word_hidden.join
  end

  def get_guess
    puts "Guess another letter or *save* your game"
    input = gets.downcase.chomp

    return input if input == "save"

    until input.length == 1 && input =~ /[a-z]/
      puts "Your guess must be one letter"
      input = gets.downcase.chomp
    end

    while @game_state["letters_guessed"].include?(input)
      puts "You already guessed that letter"
      input = gets.downcase.chomp
    end

    input
  end

  def update_game(guess)
    @game_state["letters_guessed"] << guess
    @game_state["guesses"] += 1 unless @game_state["word"].include?(guess)
  end

  def check_for_win
    @game_state["word"].chars.all? { |char| @game_state["letters_guessed"].include?(char)}
  end

  def game_won
    puts "You win! The word was #{@game_state["word"]}"
  end

  def game_lost
    puts "You lose. You'll never figure out what the word was"
  end

  def play_round
    puts "Letters guessed: #{@game_state["letters_guessed"].sort.join}"
    puts Hangman::HANGMANPICS[@game_state["guesses"]]
    display_word
    return game_lost if @game_state["guesses"] >= 6

    guess = get_guess
    return save_to_file if guess == "save"
    update_game(guess)

    check_for_win ? game_won : play_round
  end
end