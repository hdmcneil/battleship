require './lib/ship'

RSpec.describe Ship do
  before :each do
    cruiser = Ship.new("Cruiser", 3) 
  end

  it 'is instance object of SHIP' do
    expect(cruiser = Ship.new("Cruiser", 3) ).to be_an_instance_of(Ship)
  end
end