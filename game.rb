  require_relative 'board.rb'

class Game

  INPUT_TRANSLATE = generate_position_map

  def generate_position_map
    d=Hash.new
    letters = %w(a,b,c,d,e,f,g,h)
    numbers = %w(1,2,3,4,5,6,7,8)
    n=0
    letters.each do |letter|
      numbers.each do |number|
        d[letter+number] = n
        n+1
      end
    end
  end

  def initialize
    @game_board= Board.new
    @turn = white
  end

  def get_move
    begin
    puts "please enter move ie. a1,b2"
    pos = gets.chomp.split

    from, to = pos
    raise "invalid entry" if !INPUT_TRANSLATION.include?(to) or !INPUT_TRANSLATION.include?(from)

    from = INPUT_TRANSLATION[from]
    to = INPUT_TRANSLATION[to]

    raise "No piece there" if @game_board.tiles[from].class != Checker
    raise "Not yo piece" if @game_board.tiles[from].color != turn

  rescue => error
    puts error
    retry
  end

    [from, to]
  end
  def play
    while true
      puts "#{turn}'s turn'"
      checker , position = get_move
    begin
       @game_board.tiles[checker].move(position) if @game_board.tiles[checker].legal?(position)

    rescue => error
      puts error
    end

    end

  end






end
