require 'spec_helper'

RSpec.describe Player do
  before :each do
    @player = Player.new
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  # xit 'is an instance of layer class' do
  #   expect(@player).to be_an_instance_of(Player)
  # end

  # xit 'can place a cruiser' do
  #   @player.player_board.place_cruiser
  #   expect(@cruiser.length).to eq(3)
  #   expect(@board.cells.values.any?(&:ship)).to be(true)
  # end

  # xit 'can place a submarine' do
  #   @player.player_board.place_submarine
  #   expect(@submarine.length).to eq(2)
  #   expect(@board.cells.values.any?(&:ship)).to be(true)
  # end
end