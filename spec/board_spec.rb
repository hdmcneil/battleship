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
  it "will return an array the same length as the ship" do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(@board.valid_placement?(cruiser, ["A1", "A2"])).to be false
    expect(@board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
  end
  it "will have consecutive coordinates" do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(@board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
    expect(@board.valid_placement?(submarine, ["A1", "C1"])).to be false
    expect(@board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
    expect(@board.valid_placement?(submarine, ["C1", "B1"])).to be false

  end

end
