class Solver
  attr_accessor :candidates
  attr_reader :all_words

  def initialize(all_words)
    @all_words      = all_words
    self.candidates = all_words
  end

  def solve(challenge)
    new_candidates = candidates

    get_colors(challenge).each.with_index do |r, i|
      if r == '0'
        new_candidates = gray_filter(new_candidates, challenge[i], i)
      elsif r == '1'
        new_candidates = yellow_filter(new_candidates, challenge[i], i)
      else
        new_candidates = green_filter(new_candidates, challenge[i], i)
      end
    end

    if new_candidates.count == 1
      new_candidates.first
    else
      self.candidates = new_candidates
      solve(next_challenge(new_candidates))
    end
  end

  private

  def gray_filter(new_candidates, character, position)
    filtered = new_candidates.filter { |candidate| !candidate.include? character }
    filtered.empty? ? new_candidates.filter { |candidate| candidate[position] != character } : filtered
  end

  def yellow_filter(new_candidates, character, position)
    new_candidates.filter { |candidate| candidate.include?(character) && candidate[position] != character }
  end

  def green_filter(new_candidates, character, position)
    new_candidates.filter { |candidate| candidate[position] == character }
  end

  def character_ranking(new_candidates)
    ranking = {}
    ('a'..'z').each do |c|
      ranking[c] = 0
    end

    ('a'..'z').each do |c|
      new_candidates.each do |candidate|
        ranking[c] += 1 if candidate.include? c
      end
    end
    ranking
  end

  def next_challenge(new_candidates)
    ranking = character_ranking(new_candidates)

    return new_candidates.sample if new_candidates.length < 6

    score = {}
    new_candidates.each { |candidate| score[candidate] = calc_score(candidate, ranking) }
    score.to_a.sort { |a, b| a[1] <=> b[1] }[-2].first
  end

  def calc_score(word, ranking)
    word.chars.sum { |character| ranking[character] }
  end

  def get_colors(word)
    # 0 → gray
    # 1 → yellow
    # 2 → green
    raise NotImplementedError
  end
end
