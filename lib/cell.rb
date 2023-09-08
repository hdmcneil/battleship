class Cell
attr_reader :coordinate,
            :ship,
            :fired

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
    else
      @ship = nil
      @fired = true
    end
  end

  def fired_upon?
    @fired
  end

  def render(reveal = false)
    if @fired
      return "M" if @ship.nil?
      return "X" if @ship.sunk?
      return "H"
    else
     return "S" if reveal && !@ship.nil?
     return "."
    end
  end
end