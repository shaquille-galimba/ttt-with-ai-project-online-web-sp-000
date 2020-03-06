class Game
  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.any? do |combo|
      if board.taken?(combo[0]+1) && board.cells[combo[0]] == board.cells[combo[1]] && board.cells[combo[1]] == board.cells[combo[2]]
        return combo
      end
    end
  end

  def draw?
    !won? && board.full?
  end

  def over?
    draw? || won?
  end

  def winner
    if combo = won?
      board.cells[combo[0]]
    end
  end

  def turn
    input = current_player.move(board)
    if board.valid_move?(input)
      board.update(input, current_player)
      board.display
    else
      puts "Invalid move! Please pick a valid space on the board."
      board.display
      turn
    end
  end

  def play
    puts "X will start!"
    puts "Please enter a number 1-9:"
    board.board_indices
    # Included a board with the corresponding number on the spaces
    # So that players will have a guide and won't be confused.
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

  def self.wargames
    winners = []

    100.times do
      game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"))
      game.play
      winners << game.winner
    end

    x = winners.select {|w| w == "X"}.length
    y = winners.select {|w| w == "Y"}.length
    winners
    puts "X won #{x} times and Y won #{y} times."
  end
end
