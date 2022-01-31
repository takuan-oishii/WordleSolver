candidates = []

File.open('dictionary.txt', 'r') do |f|
  f.each_line { |l|
    candidates << l.chomp unless l.chomp.empty?
  }
end

def solve(candidates, challenged, result)
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

  p new_candidates
  p character_ranking new_candidates
  p next_challenge new_candidates
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
  %w[0 1 2 0 0]
end

solve candidates, 'adore', get_colors('adore')