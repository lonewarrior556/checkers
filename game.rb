  require_relative 'board.rb'

class Game

  INPUT_TRANSLATION =    {"a1" => 0, "c1" =>1 , "e1" =>2, "g1"=>3,
                          "b2" => 9, "d2" =>10, "f2"=>11, "h2"=>12,
                          "a3" => 17, "c3" =>18, "e3"=> 19, "g3"=>20,
                          "b4" => 26, "d4" =>27, "f4" =>28, "h4" =>29,
                          "a5" => 34, "c5" =>35, "e5" =>36, "g5" =>37,
                          "b6" => 43, "d6" =>44, "f6" =>45, "h6" =>46,
                          "a7" => 51, "c7" =>52, "e7" =>53, "g7" =>54,
                          "b8" => 60, "d8" =>61, "f8" =>62, "h8" =>63 }


  def initialize
    @game_board = Board.new
    @turn = :white
  end

  attr_accessor :turn
  attr_reader :game_board

  def next_turn
    @turn == :white ? @turn = :black : @turn = :white
  end

  def get_move
    begin
    puts "please enter move ie. a1,b2"
    pos = gets.chomp.split(",")
    from, to = pos

    raise "invalid entry" if !INPUT_TRANSLATION.include?(to) || !INPUT_TRANSLATION.include?(from)

    from, to = INPUT_TRANSLATION[from], INPUT_TRANSLATION[to]

    raise "No piece there" if @game_board.tiles[from].class != Checker
    raise "Not yo piece" if @game_board.tiles[from].color != turn

  rescue RuntimeError => error
    puts error
    retry
  end

    [from, to]
  end

  def play
    game_board.display
    while !game_over?
      puts "#{turn}'s turn"
      checker , position = get_move
    begin
       @game_board.tiles[checker].move(position) if @game_board.tiles[checker].legal?(position)
       next_turn
    rescue  RuntimeError => error
      puts error
    end
    game_board.display
    end
    puts "game is over"
    if game_board.tiles.select{|tile| tile.color == @turn}.length > 0
      puts "StaleMate!"
    else
      next_turn
      puts "#{turn.to_s} wins!"
    end
  end

  def game_over?
    @game_board.tiles.each do |tile|
      next if tile.nil? || tile == false
      next if tile.color != @turn
      Board::LEGAL_POSITIONS.each do |position|
        begin
          return false if tile.legal?(position)
        rescue
          next
        end
      end
    end
    true
  end

end
