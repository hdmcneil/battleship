require 'pry'
require 'optparse'
class Game
  attr_reader :player_board, :computer_board, :player_ships, :computer_ships
   def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @quit = false
    @game_over = false
   end
   def start_game
    loop do
      @board = Board.new
      @player = Player.new
      @computer = ComputerPlayer.new
      @game_over = false
      if game_over?
        display_winner
        break unless play_again?
      end
    end
    puts "Welcome to BATTLESHIP!"
    puts "Enter 'p' to play. Enter 'q' to quit."
    while !@quit
      user_input = gets.chomp.downcase
      case user_input
      when 'p'
        puts "Starting a new game..."
        start_new_game
      when 'q'
        puts "Goodbye"
        @quit = true
      else
        puts "Invalid input. Please enter 'p' to play or 'q' to quit"
      end
    end
  end
  def play_again?
    puts "Do you want to play again? (yes/no)"
    response = gets.chomp.downcase
    response == "yes"
  end
   def start_new_game
    computer.place_ships(ship, coordinates)
    player.place_ships(ship, coordinates)
   end
   def play_turns
    display_boards
    player_shot
    computer_shot unless game_over?
  end
  def display_boards
    puts "============= COMPUTER BOARD ============="
    computer_board.display(reveal_ships: false)
    puts "============== PLAYER BOARD ==============="
    player_board.display
  end
  def player_shot
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
    until valid_shot?(coordinate)
      puts "Please enter a valid coordinate:"
      coordinate = gets.chomp.upcase
    end
    result = computer_board.fire_upon(coordinate)
    display_shot_result(coordinate, result, "Your")
  end
  def computer_shot
    computer = ComputerPlayer.new
    coordinate = computer.generate_computer_shot(player_board)
    result = player_board.fire_upon(coordinate)
    display_shot_result(coordinate, result, "My")
  end
  def valid_shot?(coordinate)
    player_board.valid_coordinate?(coordinate) && !player_board.cell_fired_upon?(coordinate)
  end
  def display_shot_result(coordinate, result, player)
    case result
    when :miss
      puts "Player shot on #{coordinate} was a miss."
    when :hit
      puts "Player shot on #{coordinate} was a hit!"
    when :sunk
      puts "Player shot on #{coordinate} sunk a ship!"
    end
  end
  def game_over?
    player_ships.all?(&:sunk?) || computer_board.all_ships_sunk?
  end
  def display_winner
    if @player_ships.all?(&:sunk?)
      puts "I won! Better luck next time."
    else
      puts "Congratulations! You won Battleship!"
    end
  end
end
BattleshipGame.new.start_game