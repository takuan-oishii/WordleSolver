require './solver'

class InteractionSolver < Solver
  private

  def get_colors(word)
    puts word
    # 0 → gray
    # 1 → yellow
    # 2 → green
    while true
      colors = gets.split ' '
      return colors if colors.all? { |c| %w[0 1 2].include? c } && colors.length == 5
    end
  end
end
