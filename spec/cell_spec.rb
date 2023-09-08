require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Cell do
  before :each do
    @cell = Cell.new("B4") 
    @cell_2 = Cell.new("C3")
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

  it 'can be fired upon' do
    @cell.place_ship(@cruiser)

    expect(@cell.fired_upon?).to eq false
    
    @cell.fire_upon

    expect(@cell.ship.health).to eq 2
    expect(@cell.fired_upon?).to be true
  end
  it 'renders an empty cell that has not been fired upon' do
    
    expect(@cell.render).to eq(".")
  end

  it 'renders a missed shot' do 
    @cell.fire_upon
    cell_2.place_ship(@cruiser)

    expect(@cell.render).to eq("M")  
    expect(@cell_2.render).to  eq(".")
  end

  it 'renders a cell with a ship that has not been fired upon' do
    @cell_2.place_ship(@cruiser)

    expect(@cell_2.render(true)).to eq("S") 
  end

  it 'renders a hit when ship is fired upon' do
    @cell_2.place_ship.cruiser
    @cell_2.fire_upon

    expect(@cell_2.render).to eq("H")
  end

  it 'renders a sunken ship when a ship is sunk' do
    @cell_2.place_ship.cruiser
    @cell_2.fire_upon
    
    expect(@cruiser.sunk?).to eq false

    @cell_2.fire_upon
    @cell_2.fire_upon

    expect(@cruiser.sunk?).to eq true
    expect(@cell_2.render).to eq("X")
  end
end