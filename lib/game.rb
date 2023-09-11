require 'pry'
require 'optparse'

class Game
  attr_reader

  def initialize
    @quit = false
  end

  def start_game
    puts "Welcome to BATTLESHIP!"
    puts "Enter 'p' to play. Enter 'q' to quit."

    while !@quit
      user_input = gets.chomp.downcase

      case user_input
      when 'p'
        puts "Starting a new game..."
        setup_new_game
      when 'q'
        puts "Goodbye"
        @quit = true
      else
        puts "Invalid input. Please enter 'p' to play or 'q' to quit"
      end
    end
  end

  def setup_new_game
    computer.place_ships(ship, coordinates)
    player.place_ships(ship, coordinates)
  end
end