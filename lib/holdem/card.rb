module Holdem
  class Card
    include Comparable
    attr_reader :rank, :suit, :icon

    RANKS       = %w(2 3 4 5 6 7 8 9 T J Q K A)
    SUITS       = %w(c s d h)
    ICONS       = { 'c' => '♣', 's' => '♠', 'd' => '♦', 'h' => '♥' }
    FACE_CARDS  = { 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }

    def initialize(card)
      @rank, @suit = card.chars if card.respond_to?(:chars)
      @icon = ICONS[suit]
      validate(card)
    end

    def value
      rank[/\d/] ? rank.to_i : FACE_CARDS[rank]
    end

    def to_s
      "#{rank}#{icon}"
    end

    def <=>(other)
      value <=> other.value
    end

    private

    def validate(card)
      unless RANKS.include?(rank) && SUITS.include?(suit)
        fail ArgumentError
      end
    end
  end
end
