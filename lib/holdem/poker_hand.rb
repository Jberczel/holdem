require 'forwardable'

module Holdem
  class PokerHand
    include Comparable
    extend Forwardable

    rank_methods = [ :rank, :score, :straight_flush?, :quads?, :four_of_a_kind?,
                     :boat?, :full_house?, :flush?, :straight?, :three_of_a_kind?,
                     :trips?, :two_pairs?, :two_pair?, :pair? ]
    def_delegators :@poker_rank, *rank_methods

    attr_reader :cards, :poker_rank

    def initialize(cards)
      @cards = cards.is_a?(String) ? CardGenerator.build(cards.split) : cards
      @poker_rank = PokerRank.new(@cards)
    end

    def count
      cards.size
    end

    def <=>(other)
      score <=> other.score
    end

    def just_cards
      "#{cards.map{ |card| card.to_s }.join(' ')}"
    end

    def to_s
      "#{just_cards} -> #{rank}"
    end
  end
end
