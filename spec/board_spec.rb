require 'spec_helper'

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
  it 'won"t allow diagonal ships' do
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(@board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
    expect(@board.valid_placement?(submarine, ["C2", "D3"])).to be false 
  end
  it 'can place a ship on the board correctly' do
    @board.cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(@board.valid_placement?(submarine, ["A1", "A2"])).to be true
    expect(@board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
  end
  it "can place a ship" do
    @board.cells
    cruiser = Ship.new("Cruiser", 3)
    cell_1 = @board.cells["A1"]  
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    @board.place(cruiser, ["A1", "A2", "A3"])

    expect(cell_1.ship).to eq(cruiser)
  end

  it 'can place ship' do
    cruiser = Ship.new("Cruiser", 3) 
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    @board.place(cruiser, ["A1", "A2", "A3"])
    
    expect(cell_1).to be_an_instance_of(Cell)
    expect(cell_2).to be_an_instance_of(Cell)
    expect(cell_3).to be_an_instance_of(Cell)
    
    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
  end

  it ' does not have overlapping ships' do
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)
    expect(@board.valid_placement?(submarine, ["A1", "B1"])).to be(false)
  end

  
    it "renders an empty board without revealing ships" do
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expected_output = <<~BOARD
          1 2 3 4 
        A . . . . 
        B . . . . 
        C . . . . 
        D . . . . 

      BOARD

      expect(@board.render).to eq(expected_output.chomp)
    end

    it "renders the board with revealed ships" do
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      @board.place(cruiser, ["A1", "A2", "A3"])
      expected_output = <<~BOARD
          1 2 3 4 
        A S S S . 
        B . . . . 
        C . . . . 
        D . . . . 

      BOARD

      expect(@board.render(true)).to eq(expected_output.chomp)
    end

    it "renders the board with hits" do
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      @board.place(cruiser, ["A1", "A2", "A3"])
      @board.cells["A1"].fire_upon

      expected_output = <<~BOARD
          1 2 3 4 
        A H . . . 
        B . . . . 
        C . . . . 
        D . . . . 

      BOARD

      expect(@board.render).to eq(expected_output.chomp)
    end

    it "renders the board with misses" do
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      @board.place(cruiser, ["A1", "A2", "A3"])
      @board.cells["B4"].fire_upon

      expected_output = <<~BOARD
          1 2 3 4 
        A . . . . 
        B . . . M 
        C . . . . 
        D . . . . 

      BOARD

      expect(@board.render).to eq(expected_output.chomp)
    end

    it "renders the board with a sunk ship" do
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      @board.place(cruiser, ["A1", "A2", "A3"])
      #  require 'pry'; binding.pry
      @board.cells["A1"].fire_upon
      @board.cells["A2"].fire_upon
      @board.cells["A3"].fire_upon

      expected_output = <<~BOARD
          1 2 3 4 
        A X X X . 
        B . . . . 
        C . . . . 
        D . . . . 

      BOARD

      expect(@board.render).to eq(expected_output.chomp)
    end


end
