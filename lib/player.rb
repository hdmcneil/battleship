require 'pry'
require 'optparse'

class Player
  attr_reader :player_board, :player_ships
  def initialize
    @player_board = Board.new
    @player_ships = []
  end
  def place_ships
    place_cruiser
    place_submarine
  end
  def place_cruiser
    cruiser = Ship.new("Cruiser", 3)
    puts "I have placed my ships on the board."
    puts "It is your turn to place your ships on the board."
    puts "The Cruiser is three units long and the submarine is two units long"
    loop do
      puts "Enter the squares for the Cruiser (3 spaces):"
      cruiser_placement = gets.chomp.upcase
      coordinates = cruiser_placement.split
      if @player_board.valid_placement?(cruiser, coordinates)
        @player_board.place(cruiser, coordinates)
        break
      else
        puts "That is not a valid placement. Please re-enter coordinates:"
      end
    end
    @player_ships << cruiser
  end
  def place_submarine
    submarine = Ship.new("Submarine", 2)
    loop do
      puts "Enter the squares for the Submarine (2 spaces):"
      submarine_placement = gets.chomp.upcase
      coordinates = submarine_placement.split
      if @player_board.valid_placement?(submarine, coordinates)
        @player_board.place(submarine, coordinates)
        break
      else
       puts "That is not a valid placement. Please re-enter coordinates:"
      end
    end
    @player_ships<< submarine
  end
end