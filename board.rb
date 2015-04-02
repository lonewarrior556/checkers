require_relative "checker"

class Board

  LEGAL_POSITIONS= [(0..3),(9..12),(17..20),(26..29),
                    (34..37),(43..46),(51..54),
                    (60..63)].map{|x|x.to_a}.flatten



  def initialize()
    @tiles

  end


  def set_board
    temp_board = []
    color = :white
    (0..63).to_a.each do |n|
      color = :black if n>50
      if LEGAL_POSITIONS.include?(n) && color ==:white
        temp_board << Checker.new(color,n,self)
      elsif LEGAL_POSITIONS.include?(n) && color ==:black
        temp_board << Checker.new(color,n,self)
      else
        temp_board << nil
      end
    end
  end











end
