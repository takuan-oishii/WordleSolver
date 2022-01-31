words = []

File.open('dictionary.txt', 'r') do |f|
  f.each_line { |l|
    words << l.chomp unless l.chomp.empty?
  }
end

count = {}
('a'..'z').each do |c|
  count[c] = 0
end

('a'..'z').each do |c|
  words.each do |word|
    count[c] += 1 if word.include? c
  end
end

count = count.to_a.sort_by { |a| a[1] }.reverse

first_word_candidates = words.map do |word|
  if count[0..3].map { |c| c[0] }.all? { |c| word.include? c }
    word
  else
    nil
  end
end.compact

File.open('character_statistics.result', 'w') do |f|
  f.puts "総単語数: #{words.count}"
  f.puts
  f.puts "使われてる文字ランキング"
  count.each { |a| f.puts "#{a[0]}: #{a[1]}語" }
  f.puts
  f.puts "初手に選ぶと強い単語候補"
  first_word_candidates.each { |a| f.puts a }
end