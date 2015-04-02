class Checker

  MOTIONS = [8,9,16,18,-8,-9,-16,-18]

  DRAW = { [true, :black]=>♚, [true, :white] =>♔,
      [false, :black] => ◉, [false, :white] => ◎}


  attr_reader :color, :board

  attr_accessor :king, :position


  def initialize(color, value, board)
    @color = color
    @king = false
    @value = value
    @board = board
  end


  def legal?(pos)
    motions = MOTIONS[4..-1] if color == :black
    motions = MOTIONS[0..3]  if color == :white
    motions = MOTIONS if king

    raise "illegal square" if !Board::LEGAL_POSITIONS.include?(pos)

    raise "illegal move" if !motions.map{|x|x + @value}.include?(pos)

    raise "piece there" if !@board.tiles[pos].nil?

    raise "no piece to jump" if (pos-value).abs > 10 && !@board.tiles[(pos-value)/2 + value].nil?

    true
  end


  def move(pos)
    @board.tiles[(pos-value)/2 + value] = nil if (pos-value).abs > 10
    @board.tiles[value] = nil
    @value = pos
    @board.tiles[value] = self
  end


  def show
    DRAW[king,color]
  end









end
