require 'pry'
require './lib/board'

class ComputerPlayer
  attr_reader :computer_board, :computer_ships
  def initialize
    @computer_board = Board.new
    @computer_ships = []
  end
  def place_ships
    place_cruiser
    place_submarine
  end
  def place_cruiser
    cruiser = Ship.new("Cruiser", 3)
    valid_placement = false
    until valid_placement
      coordinates = generate_random_coordinates(cruiser.length)
      valid_placement = @computer_board.valid_placement?(cruiser, coordinates)
    end
    @computer_board.place(cruiser, coordinates)
    @computer_ships << cruiser
    @computer_board.render
  end
  def place_submarine
    submarine = Ship.new("Submarine", 2)
    valid_placement = false
    until valid_placement
      coordinates = generate_random_coordinates(submarine.length)
      valid_placement = @computer_board.valid_placement?(submarine, coordinates)
    end
    # binding.pry
    @computer_board.place(submarine, coordinates)
    @computer_ships << submarine
    @computer_board.render
  end
  def generate_random_coordinates(ship_length)
    rows = ["A", "B", "C", "D"]
    columns = ["1", "2", "3", "4"]
    random_row = rows.sample
    random_column = columns.sample
    initial_coordinate = random_row + random_column
    coordinates = [initial_coordinate]
    (ship_length -1).times do
      if rand(2) == 0
        next_row = rows.index(random_row) + rand(ship_length)
        next_row = [next_row, rows.length - 1].min
        coordinates << rows[next_row] + random_column
      else
        next_column = columns.index(random_column) + rand(ship_length)
        next_column = [next_column, columns.length - 1].min
        coordinates << random_row + columns[next_column]
      end
    end
    coordinates
  end
end
