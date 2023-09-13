require 'spec_helper'

RSpec.describe ComputerPlayer do
  before :each do
    @computer = ComputerPlayer.new
    @board = @computer.computer_board
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  it 'is an instance of ComputerPlayer class' do
    expect(@computer).to be_an_instance_of(ComputerPlayer)
  end

  it 'can place a cruiser' do
    @computer.place_cruiser
    cruiser_cells = @board.cells.values.select { |cell| cell.ship == @cruiser }
    expect(cruiser_cells.length).to eq(3)
    expect(cruiser_cells.all? { |cell| cell.ship == @cruiser }).to be(true)
  end

  it 'can place a submarine' do
    @computer.place_submarine
    submarine_cells = @board.cells.values.select { |cell| cell.ship == @submarine }
    expect(submarine_cells.length).to eq(2)
    expect(submarine_cells.all? { |cell| cell.ship == @submarine }).to be(true)
  end

  it 'generates valid random coordinates for ship placement' do
    coordinates = @computer.generate_random_coordinates(3)
    expect(coordinates.length).to eq(3)
    expect(coordinates.all? { |coord| @board.valid_coordinate?(coord) }).to be true
  end
end