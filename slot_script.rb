require 'pry'

class SlotScript
  SYMBOLS = ['9','10','J','Q','K','cat','dog','mon','bir']
  PAY_LINES = [[0,1,2,3,4], 
               [5,6,7,8,9],
               [10,11,12,13,14],
               [0,6,12,8,4],
               [10,6,2,8,14]]
  PAY_BETS = {3 => 0.2, 4 => 2, 5 => 10, 1 => 0, 2=> 0 }
  
  attr_accessor :bet_amount

  def initialize(bet_amount = 100)
    @bet_amount = bet_amount  
  end

  def execute
    paylines = get_paylines(board)
    output = { 
      "board" => mix_simbols,
      "paylines" => paylines,
      "bet_amount" => bet_amount,
      "total_win" => total_win(paylines)
    }
    
    puts output.to_s
  end

  def get_paylines(board)
    output = []
    PAY_LINES.each do |pay_line|
      line = []
      pay_line.each do |line_pos|
        line << board[line_pos]
      end
      output << game_score(line) unless game_score(line).nil?
    end
    output
  end

  def mix_simbols
    rand_array = Array.new(15) { SYMBOLS[ rand(SYMBOLS.length) ] }
  end

  def game_score(line)
    { line.join(' ') => self.class.repetitions(line) } if self.class.repetitions(line) > 2
  end

  def self.repetitions(line)
    counts = line.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }
    counts.values.sort.last
  end

  def total_win(paylines)
    return 0 if paylines.empty?
    win = 0
    paylines.each do |payline|
      win += bet_amount * PAY_BETS[payline.values.first]
    end
    win
  end
end

SlotScript.new.execute