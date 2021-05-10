require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    (0...3).each do |i|
      (0...3).each do |j|
        if board.empty?([i,j])
          b = board.dup
          b[[i, j]] = next_mover_mark
            next_mover_mark == :x ? new_mark = :o : new_mark = :x
            node = TicTacToeNode.new(b, new_mark ,[i, j])
            result << node
        end
      end
    end

    result
  end

  def losing_node(evaluator)
    node_children = self.children
    rec_call = false

    node_children.each do |node| 
      if node.board.over?
        if node.board.winner != evaluator
          return true
        ends
      else
        rec_call = node.losing_node(evaluator)
      end
    end
    
    return rec_call
  end


end
