class Board
  MARKERS = {
    nil => " ",
    :s  => " ",
    :x  => "x"
  }

  attr_reader :grid

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def initialize(grid = Board.default_grid)
    @grid = grid
    populate_grid
  end

  def display
    header = (0..9).to_a.join(" ")
    puts " #{header}"
    @grid.each_with_index do |row, i|
      puts "#{i}#{display_row(row, i)}"
    end
  end

  def display_row(row, i)
    current_row = row.map { |el| MARKERS[el] }
    current_row.join(" ")
  end

  def populate_grid
    10.times do |i|
      place_random_ship
    end
  end

  def in_range?(pos)
    range = false
    pos.each do |coord|
      if coord.between?(0, 9)
        range = true
      else
        range = false
      end
    end

    range
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def count
    num_of_ships = 0
    grid.flatten.each { |el| num_of_ships += 1 if el == :s }
    num_of_ships
  end

  def empty?(pos = nil)
    if !pos.nil?
      if self[pos].nil?
        return true
      else
        return false
      end
    end
    return true if @grid.flatten.all? { |el| el.nil? }
  end

  def full?
    @grid.flatten.none?(&:nil?)
  end

  def place_random_ship
    raise "full!" if full?
    pos = randompos

    until empty?(pos)
      pos = randompos
    end

    self[pos] = :s
  end

  def randompos
    [rand(grid.length), rand(grid.length)]
  end

  def won?
    @grid.flatten.none? { |el| el == :s }
  end
end
