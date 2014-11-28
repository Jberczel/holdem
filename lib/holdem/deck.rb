class Deck < Array
  def initialize
    build_deck
  end

  # add test for #deal
  alias_method :deal, :pop

  private

  def build_deck
    Card::RANKS.each do |rank|
      Card::SUITS.each { |suit| self << Card.new(rank + suit) }
    end
  end
end
