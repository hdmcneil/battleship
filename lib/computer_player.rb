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
    
    @computer_board.place(submarine, coordinates)
    @computer_ships << submarine
    @computer_board.render
  end
  def generate_random_coordinates(ship_length)
    rows = ["A", "B", "C", "D"]
    columns = ["1", "2", "3", "4"]
  
    # Randomly decide whether to place the ship vertically or horizontally
    vertical_placement = rand(2) == 0
  
    if vertical_placement
      # Randomly choose the row for the initial coordinate
      initial_row = rows.sample
  
      # Ensure that the ship will fit vertically on the board
      while rows.index(initial_row) + ship_length > rows.length
        initial_row = rows.sample
      end
  
      # Randomly choose the column for the initial coordinate
      initial_column = columns.sample
  
      initial_coordinate = initial_row + initial_column
      coordinates = [initial_coordinate]
  
      (ship_length - 1).times do |i|
        next_row_index = rows.index(initial_row) + i + 1
        next_row = rows[next_row_index]
        coordinates << next_row + initial_column
      end
    else
      # Randomly choose the row for the initial coordinate
      initial_row = rows.sample
  
      # Randomly choose the column for the initial coordinate
      initial_column = columns.sample
  
      # Ensure that the ship will fit horizontally on the board
      while columns.index(initial_column) + ship_length > columns.length
        initial_column = columns.sample
      end
  
      initial_coordinate = initial_row + initial_column
      coordinates = [initial_coordinate]
  
      (ship_length - 1).times do |i|
        next_column_index = columns.index(initial_column) + i + 1
        next_column = columns[next_column_index]
        coordinates << initial_row + next_column
      end
    end
  
    coordinates
  end
  
end