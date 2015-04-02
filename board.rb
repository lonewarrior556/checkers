require_relative "checker"
require 'byebug'

class Board

  LEGAL_POSITIONS= [(0..3),(9..12),(17..20),(26..29),
                    (34..37),(43..46),(51..54),
                    (60..63)].map{|x|x.to_a}.flatten

  def initialize()
    @tiles = set_board
  end

  attr_accessor :tiles

  def set_board
    temp_board = []
    (0..63).to_a.each do |n|
      if LEGAL_POSITIONS.include?(n)
        if n<21
          temp_board << Checker.new(:white,n,self)
        elsif n>42
          temp_board << Checker.new(:black,n,self)
        else
          temp_board << false
        end
      else
        temp_board << nil
      end
    end
    temp_board
  end


  def display
    temp=Array.new(8){Array.new(8)}
    %w(1 2 3 4 5 6 7 8).reverse.each_with_index do |number,i|
      %w(a b c d e f g h).each_with_index do |letter, j|
        temp[i][j] = Game::INPUT_TRANSLATION[letter+number]
      end
    end

    puts "  A  B  C  D  E  F  G  H "
    n=8
    temp.each do |row|
      draw = n.to_s
      row.each do |tile|
        if tile.nil?
          draw+= " _ "
        elsif @tiles[tile]==false
          draw+= " _ "
        else
          draw+= @tiles[tile].show
        end
      end
      puts draw
      n-=1
    end
    nil
  end

end
