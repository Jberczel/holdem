require 'forwardable'

module Holdem
  class Deck
    extend Forwardable
    def_delegators :@deck, :shuffle, :shuffle!, :pop, :size
    attr_reader :deck

    def initialize
      @deck = []
      build_deck
    end

    alias_method :deal, :pop
    alias_method :count, :size

    private

    def build_deck
      Card::RANKS.each do |rank|
        Card::SUITS.each { |suit| deck << Card.new(rank + suit) }
      end
    end
  end
end
