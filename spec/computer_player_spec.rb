require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game_setup'
require './lib/computer_player'
require 'pry'

RSpec.describe Board do
  before :each do
    @computer = ComputerPlayer.new
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  it 'is an instance of ComputerPlayer class' do
    expect(@computer).to be_an_instance_of(ComputerPlayer)
  end

  it 'can place a cruiser' do
    @computer.place_cruiser(@board)
    expect(@cruiser.length).to eq(3)
    expect(@board.cells.values.any?(&:ship)).to be(true)
    # binding.pry
    
  end

  it 'can place a submarine' do
    @computer.place_submarine(@board)
    expect(@submarine.length).to eq(2)
    expect(@board.cells.values.any?(&:ship)).to be(true)
  end
end