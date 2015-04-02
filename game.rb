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
