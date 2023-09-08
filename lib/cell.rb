class Cell
attr_reader :coordinate,
            :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired = false
  

  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship

  end
  
  def fire_upon
    if @ship
      @ship.hit 
      @fired = true
    end
  end

  def fired_upon?
    @fired
  end

  
end