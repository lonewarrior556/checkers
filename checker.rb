class Checker

  MOTIONS = [8,9,16,18,-8,-9,-16,-18]

  KING_SPOT = { :black => [0,1,2,3], :white => [60,61,62,63]}

  DRAW = { [true, :black]=>"♚", [true, :white] => "♔",
      [false, :black] => "◉", [false, :white] => "◎"}


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

    raise "piece there" if @board.tiles[pos] ==false

    if (pos-value).abs > 10
    raise "no piece to jump" if  @board.tiles[(pos-value)/2 + value] == false
    raise "can't jump your own piece" if @board.tiles[(pos-value)/2 + value].color == color
    end

    true
  end


  def move(pos)
    @board.tiles[(pos-value)/2 + value] = false if (pos-value).abs > 10
    @board.tiles[value] = false
    @value = pos
    @board.tiles[value] = self
    @king = true if KING_SPOT[color].include?(pos)
  end


  def show
    DRAW[[king,color]]
  end






end
