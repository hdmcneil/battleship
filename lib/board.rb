class Board
attr_reader :cells

  def initialize
    @cells = generate_cells
  end

  def generate_cells
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

    coordinates.each_with_index do |coordinate, index|
      return false unless valid_coordinate?(coordinate)
      cell = @cells[coordinate]
      return false unless cell.empty?
    # binding.pry
        next_coordinate = coordinates[index + 1]
        if next_coordinate
          row, col = coordinate[0], coordinate[1..-1].to_i
          next_row, next_col = next_coordinate[0], next_coordinate[1..-1].to_i

      horizontal = coordinates.include?("#{row}#{col - 1}") || coordinates.include?("#{row}#{col + 1}")

      vertical = coordinates.include?("#{(row.ord - 1).chr}#{col}") || coordinates.include?("#{(row.ord + 1).chr}#{col}")

      return false unless horizontal || vertical || next_coordinate < coordinate
     
      if row == next_row
        return false unless next_col == col + 1
      elsif col == next_col
        return false unless next_row.ord == row.ord + 1
      end

      diagonal_ascending = coordinates.include?("#{(row.ord - 1).chr}#{col - 1}") || coordinates.include?("#{(row.ord + 1).chr}#{col + 1}")

      diagonal_descending = coordinates.include?("#{(row.ord - 1).chr}#{col + 1}") || coordinates.include?("#{(row.ord + 1).chr}#{col - 1}")

      return false if diagonal_ascending || diagonal_descending
      end
    end
    return true
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      cell = @cells[coordinate]
      cell.place_ship(ship)
    end
  end
  def render(reveal = false)
      header = "  1 2 3 4 \n"
      rows = ["A", "B", "C", "D"]
      board  = header

      rows.each do |row|
        board <<  row + " "
        (1..4).each do |col|
          cell = @cells[row + col.to_s]
          if cell.fired_upon?
            if cell.empty?
              board << "M "
            elsif cell.ship.sunk?
              board << "X "
            else
              board << "H "
            end
          else
            if reveal && !cell.empty?
              board << "S "
            else 
              board << ". "
            end
          end
        end
        board << "\n"
      end
      board
    end
end
