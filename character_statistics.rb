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

p

File.open('character_statistics.result', 'w') do |f|
  f.puts "総単語数: #{words.count}"
  f.puts
  f.puts "使われてる文字ランキング"
  count.to_a.sort_by { |a| a[1] }.reverse.each do |a|
    f.puts "#{a[0]}: #{a[1]}語"
  end
end