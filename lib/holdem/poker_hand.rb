class PokerHand
  include Comparable
  attr_reader :cards, :poker_rank

  def initialize(cards)
    @cards = cards.is_a?(String) ? CardGenerator.build(cards.split) : cards
    @poker_rank = PokerRank.new(@cards)
  end

  def rank
    poker_rank.rank
  end

  def score
    poker_rank.score
  end

  def count
    cards.size
  end

  def <=>(other)
    score <=> other.score
  end

  def to_s
    "#{cards.map{ |card| card.to_s }.join(' ')} -> #{rank}"
  end
end