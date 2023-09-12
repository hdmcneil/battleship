require_relative 'board'     
require_relative 'cell'
require_relative 'ship'
require_relative 'player'
require_relative 'computer_player'
require_relative 'game'

# Create a new game instance
game = Game.new

# Start the game
game.start_game
