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
        if n<13
          temp_board << Checker.new(:white,n,self)
        elsif n>50
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


  

#may still have errors
  def display
    temp = @tiles.compact.zip([nil]*32).flatten
    temp_board = temp.each_slice(8).to_a
    temp_board.reverse.each_with_index do |row, i|
      str=''
      if i%2==0
        row = row.reverse
      end
      row.each do |spot|
        if spot == false
          str+="_"
        elsif spot.nil?
          str+="-"
        else
          str += spot.show
        end
      end
      puts str
    end
    nil
  end










end
