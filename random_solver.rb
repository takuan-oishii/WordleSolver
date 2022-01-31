require './solver'

class RandomSolver < Solver
  attr_reader :seikai

  def initialize(all_words)
    super all_words
    @seikai = all_words.sample
    puts "今回の正解は #{@seikai}"
  end

  private

  def get_colors(word)
    puts word
    # 0 → gray
    # 1 → yellow
    # 2 → green
    word.chars.map.with_index do |w, i|
      if w == @seikai[i]
        '2'
      elsif @seikai.include? w
        '1'
      else
        '0'
      end
    end
  end
end
