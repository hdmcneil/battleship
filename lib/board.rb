class Board
attr_reader :cells

  def initialize
    @cells = {}

  end

  def cells
    @cells = {
     "A1" => Cell.new("A1"),
     "A2" => Cell.new("A2"),
     "A3" => Cell.new("A3"),
     "A4" => Cell.new("A4"),
     "B1" => Cell.new("B1"),
     "B2" => Cell.new("B2"),
     "B3" => Cell.new("B3"),
     "B4" => Cell.new("B4"),
     "C1" => Cell.new("C1"),
     "C2" => Cell.new("C2"),
     "C3" => Cell.new("C3"),
     "C4" => Cell.new("C4"),
     "D1" => Cell.new("D1"),
     "D2" => Cell.new("D2"),
     "D3" => Cell.new("D3"),
     "D4" => Cell.new("D4")
    }
  end
  def valid_coordinate?(coordinate)
    @cells.key?(coordinate) 
  end
  def valid_placement?(ship, coordinates)

   return false unless coordinates.length == ship.length
    coordinates.each do |coordinate|
      return false unless valid_coordinate?(coordinate) 
      
    end

    coordinates.each do |coordinate|
      return false unless @cells.key?(coordinate)
      cell = @cells[coordinate]
      return false unless cell.empty?
    end

    coordinates.each do |coordinate|
      return false unless @cells.key?(coordinate)

      row, col = coordinate[0], coordinate[1..-1].to_i

      horizontal = coordinates.include?("#{row}#{col - 1}") || coordinates.include?("#{row}#{col + 1}")
      
      vertical = coordinates.include?("#{(row.ord - 1).chr}#{col}") || coordinates.include?("#{(row.ord + 1).chr}#{col}")
      return false unless horizontal || vertical

      diagonal_ascending = coordinates.include?("#{(row.ord - 1).chr}#{col - 1}") || coordinates.include?("#{(row.ord + 1).chr}#{col + 1}")
      
      diagonal_descending = coordinates.include?("#{(row.ord - 1).chr}#{col + 1}") || coordinates.include?("#{(row.ord + 1).chr}#{col - 1}")

      return false if diagonal_ascending || diagonal_descending   
    end
      true
  end

  def place(ship, coordinates)
    return false unless valid_placement?(ship, coordinates)
    coordinates.each do |coordinate|
      cell = @cells[coordinate]
      cell.place_ship(ship)
      
    end
  end
end
