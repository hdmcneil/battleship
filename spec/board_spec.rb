require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

RSpec.describe Board do
  before :each do
    @board = Board.new
    
  end

  it 'is an instance of Board' do
   expect(@board).to be_an_instance_of(Board)
  end

  it 'has cells' do
    expect(@board.cells).to be_a(Hash)
  end

  it 'has 16 key/value pairs' do
    
    expect(@board.cells.length).to eq(16)
  end

end
