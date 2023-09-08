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
  it 'contains keys pointing to Cell objects' do
    @board.cells.each do |key, value|
      
      expect(value).to be_a(Cell)
    end
  end
  it 'will tell us if a coordinate is on the board or not' do
    @board.cells

    expect(@board.valid_coordinate?("A1")).to eq true 
    expect(@board.valid_coordinate?("D4")).to eq true 
    expect(@board.valid_coordinate?("A5")).to eq false 
    expect(@board.valid_coordinate?("E1")).to eq false 
    expect(@board.valid_coordinate?("A22")).to eq false 
  end

end
