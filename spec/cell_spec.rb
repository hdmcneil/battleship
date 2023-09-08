require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Cell do
  before :each do
    @cell = Cell.new("B4") 
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'is instance object of Cell' do
    expect(@cell = Cell.new("B4")).to be_an_instance_of(Cell)
  end
    
  it 'has attributes' do
    expect(@cell.coordinate).to eq("B4")
    expect(@cell.ship).to eq(nil)
    expect(@cell.empty?).to eq(true)
  end

  it 'can place a ship' do
    @cell.place_ship(@cruiser)

    expect(@cell.ship).to eq(@cruiser)
    expect(@cell.empty?).to be(false)
  end
  

end