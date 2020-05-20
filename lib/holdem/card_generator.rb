module Holdem
  class CardGenerator
    def self.build(cards)
      new(cards).cards
    end

    attr_reader :cards
    
    def initialize(cards)
      @cards = cards.each.map { |c| Card.new(c) }
    end
  end
end
