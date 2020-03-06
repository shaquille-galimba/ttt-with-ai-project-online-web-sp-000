module Players
  class Computer < Player

    def move(board)
      corner = ["1", "3", "7", "9"].find {|idx| board.valid_move?(idx)}
      mid = ["2", "4", "6", "8"].find {|idx| board.valid_move?(idx)}

      if board.cells[4] == " "
        "5"
      elsif corner != nil
        corner
      else
        mid
      end

    end

  end
end
