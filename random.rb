require './random_solver'

all_words = []

File.open('dictionary.txt', 'r') do |f|
  f.each_line { |l|
    all_words << l.chomp unless l.chomp.empty?
  }
end

solver = RandomSolver.new(all_words)
answer = solver.solve 'arose'
puts "answer = #{answer}"
