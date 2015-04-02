class Checker

  MOTIONS = [8,9,16,18,-8,-9,-16,-18]

  KING_SPOT = { :black => [0,1,2,3], :white => [60,61,62,63]}

  DRAW = { [true, :black]=>" ♚ ", [true, :white] => " ♔ ",
      [false, :black] => " ◉ ", [false, :white] => " ◎ "}

  attr_reader :color, :board
  attr_accessor :king, :value

  def initialize(color, value, board)
    @color = color
    @king = false
    @value = value
    @board = board
  end

  def legal?(pos)
    raise "your not really moving..." if pos == value

    motions = MOTIONS[4..-1] if color == :black
    motions = MOTIONS[0..3]  if color == :white
    motions = MOTIONS if king

    raise "illegal square" if !Board::LEGAL_POSITIONS.include?(pos)
    raise "illegal move" if !motions.map{|x|x + @value}.include?(pos)
    raise "piece there" if @board.tiles[pos] != false

    if (pos-value).abs > 10
      raise "no piece to jump" if  @board.tiles[(pos-value)/2 + value] == false
      raise "can't jump your own piece" if @board.tiles[(pos-value)/2 + value].color == color
    end

    true
  end

  def next_jump
    #check if next jumps are possible
    #list positions, as user to input next position
    #make sure its in the possible ones
  end

  def move(pos)
    distance = pos-value
    @board.tiles[(distance)/2 + value] = false if (distance).abs > 10
    @board.tiles[value] = false
    @value = pos
    @board.tiles[value] = self
    if distance >10
      next_pos = next_jump
      #move(next_pos)
    end

    @king = true if KING_SPOT[color].include?(pos)
  end

  def show
    DRAW[[king,color]]
  end

  def ignore_exception
     begin
       yield
     rescue Exception
    end
  end


end
