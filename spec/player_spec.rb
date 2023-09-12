require 'spec_helper'

RSpec.describe Player do
  before :each do
    @player = Player.new
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  it 'is an instance of ComputerPlayer class' do
    
  end

  it 'can place a cruiser' do
    
  end

  it 'can place a submarine' do
   
  end
end