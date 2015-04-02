class Checker

  attr_reader :color, :board

  attr_accessor :king, :position


    def initialize(color, value, board)
      @color = color
      @king = false
      @value = value
      @board = board
    end


    def legal?(pos)
      motions =[8,9,16,18,-8,-9,-16,-18]
      if king
        "nothing"
      elsif color == :black
        motions = motions[4..-1]
      else
        motions - motions[0..3]
      end
      raise "illegal square" if !Board::LEGAL_POSITIONS.include?(pos)

      raise "illegal move" if !motions.map{|x|x + @value}.include?(pos)

      raise "piece there" if !@board.tiles[pos].nil?

      raise "no piece to jump" if (pos-value)>10 && !@board.tiles[(pos-value)/2 + value].nil?

      true
    end



    def move(pos)











end
