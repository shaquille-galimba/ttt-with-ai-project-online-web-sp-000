class Board
  attr_accessor :cells

  def initialize
    reset!
  end

  def reset!
    self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display
    separator = "-----------"
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts separator
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts separator
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  def board_indices
    separator = "-----------"
    puts " 1 | 2 | 3 "
    puts separator
    puts " 4 | 5 | 6 "
    puts separator
    puts " 7 | 8 | 9 "
  end

  def idx(input)
    input.to_i - 1
  end

  def position(input)
    cells[idx(input)]
  end

  def full?
    cells.all? {|v| v != " "}
  end

  def turn_count
    cells.select {|v| v != " "}.length
  end

  def taken?(input)
    position(input) != " "
  end

  def valid_move?(input)
    !taken?(input) && idx(input).between?(0, 8)
  end

  def update(input, player)
    cells[idx(input)] = player.token if valid_move?(input)
    puts "#{player.token} moves to #{input}"
    # I included a message so that players would know their opponent's last move.
  end
end
