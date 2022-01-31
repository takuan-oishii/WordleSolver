candidates = []

File.open('dictionary.txt', 'r') do |f|
  f.each_line { |l|
    candidates << l.chomp unless l.chomp.empty?
  }
end

SEIKAI = candidates.sample

def solve(candidates, challenged, result)
  p challenged
  new_candidates = candidates

  result.each.with_index do |r, i|
    if r == '0'
      new_candidates = gray_filter(new_candidates, challenged[i])
    elsif r == '1'
      new_candidates = yellow_filter(new_candidates, challenged[i], i)
    else
      new_candidates = green_filter(new_candidates, challenged[i], i)
    end
  end

  if new_candidates.count == 1
    new_candidates.first
  else
    will_challenge = next_challenge(new_candidates)
    solve(new_candidates, will_challenge, get_colors(will_challenge))
  end
end

def gray_filter(candidates, character)
  candidates.filter { |candidate| !candidate.include? character }
end

def yellow_filter(candidates, character, position)
  candidates.filter { |candidate| candidate.include?(character) && candidate[position] != character }
end

def green_filter(candidates, character, position)
  candidates.filter { |candidate| candidate[position] == character }
end

def character_ranking(candidates)
  ranking = {}
  ('a'..'z').each do |c|
    ranking[c] = 0
  end

  ('a'..'z').each do |c|
    candidates.each do |candidate|
      ranking[c] += 1 if candidate.include? c
    end
  end
  ranking
end

def next_challenge(candidates)
  ranking = character_ranking candidates

  score = {}
  candidates.each { |candidate| score[candidate] = calc_score(candidate, ranking) }
  score.to_a.sort_by { |s| s[1] }.last.first
end

def calc_score(word, ranking)
  word.chars.sum { |character| ranking[character] }
end

def get_colors(word)
  # 0 → gray
  # 1 → yellow
  # 2 → green
  word.chars.map.with_index do |w, i|
    if w == SEIKAI[i]
      '2'
    elsif SEIKAI.include? w
      '1'
    else
      '0'
    end
  end
end

answer = solve candidates, 'adore', get_colors('adore')

puts "answer = #{answer}"