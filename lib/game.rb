require 'pry'
require './lib/computer_player'
require './lib/player'
require 'optparse'
class Game
  attr_reader :quit, :game_over, :computer_player, :player, :used_coordinates
   def initialize
    @computer_player = ComputerPlayer.new
    @player = Player.new
    @quit = false
    @game_over = false
    @used_coordinates = []
   end
   def play_again?
    puts "Do you want to play again? (yes/no)"
    response = gets.chomp.downcase
    response == "yes"
   end
   def start_new_game
    @computer_player.place_ships
    puts @player.player_board.render
    @player.place_ships
    play_turns
   end
   def reset_game 
      @player_board
      @computer_board
      @player 
      @computer 
      @game_over = false
   end
   def start_game
    loop do
      reset_game 
      
    puts "Welcome to BATTLESHIP!"
    while !@quit
    puts "Enter 'p' to play. Enter 'q' to quit."
      user_input = gets&.chomp.downcase
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
        if game_over?
          display_winner
          break unless play_again?
        end
      end
    end
  end
  
   def play_turns
    display_boards
    loop do
      player_shot
      break if game_over?
       computer_shot
       display_boards
      break if  game_over?
    end
  end
  def display_boards
    puts "============= COMPUTER BOARD ============="
   puts @computer_player.computer_board.render(reveal = false)
    puts "============== PLAYER BOARD ==============="
   puts @player.player_board.render(reveal = true)
  end
  def player_shot
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
    until valid_shot?(coordinate)
      puts "Please enter a valid coordinate:"
      coordinate = gets.chomp.upcase
    end
    cell = @computer_player.computer_board.cells[coordinate]
    cell.fire_upon
    display_player_shot(coordinate)

  end

  def computer_shot
    rows = ["A", "B", "C", "D"]
    columns = ["1", "2", "3", "4"]
    
    available_coordinates = rows.product(columns).map { |row, col| "#{row}#{col}" } - @used_coordinates

    selected_coordinate = available_coordinates.sample
    @used_coordinates << selected_coordinate
    
    @player.player_board.cells[selected_coordinate].fire_upon

    display_computer_shot(selected_coordinate)
  end
  

 
  def valid_shot?(coordinate)
    cell = @computer_player.computer_board.cells[coordinate]
    @computer_player.computer_board.valid_coordinate?(coordinate) && !cell.fired_upon?
  end
  def display_player_shot(coordinate)
   result = @computer_player.computer_board.cells[coordinate]
    if result.render == "H"
        puts "Player shot on #{result.coordinate} was a hit!"
       elsif result.render == "M"
         puts "Player shot on #{result.coordinate} was a miss!"
      else result.render == "X"
        puts "Player shot on #{coordinate} sunk my #{result.ship.name}!"
    end
  end
  def display_computer_shot(coordinate)
   result = @player.player_board.cells[coordinate]
    if result.render == "H"
        puts "Computer shot on #{result.coordinate} was a hit!"
       elsif result.render == "M"
         puts "Computer shot on #{result.coordinate} was a miss!"
      else result.render == "X"
        puts "Computer shot on #{coordinate} sunk your #{result.ship.name}!"
    end
  end
  def game_over?
    @player.player_ships.all?{ |ship| ship.sunk?} || @computer_player.computer_ships.all? { |ship| ship.sunk?}
  end
  def display_winner
    if @player.player_ships.all? { |ship| ship.sunk?}
      puts "I won! Better luck next time."
    else
      puts "Congratulations! You won Battleship!"
    end
  end
end
