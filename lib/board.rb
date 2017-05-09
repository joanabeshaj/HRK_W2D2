class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new(4, :stone)}
    @cups[6], @cups[13] = [], []
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    unless (start_pos.between?(1,6) || start_pos.between?(8, 13))
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    next_cup = start_pos
    until stones.empty?
      next_cup = next_cup + 1
      next_cup == 0 if next_cup > 13 
      
      if (next_cup == 6 && current_player_name == @name1)
        @cups[next_cup] << stones.pop 
      elsif (next_cup == 13 && current_player_name == @name2)
        @cups[next_cup] << stones.pop 
      else
        @cups[next_cup] << stones.pop 
      end
      
    end
      
      render
      next_turn(next_cup)
    
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch 
    else
    ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    cups[0..5].all? { |cup| cup.empty? } ||
    cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    player1_stones = @cups[6].length 
    player2_stones = @cups[13].length
    
    case player1_stones <=> player2_stones
    when -1 
      @name2
    when 1
      @name1
    when 0
      :draw
    end
  end
  
end
