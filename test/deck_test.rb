require_relative 'test_helper'

class DeckTest < Minitest::Test

  def setup
    @deck = Holdem::Deck.new
  end

  def test_deck_has_52_cards
    assert_equal 52, @deck.count
  end

  def test_deck_next_card
    card = Holdem::Deck.new.pop
    assert_equal card, @deck.pop
    assert_equal 51, @deck.size
  end

  def test_shuffle
    unshuffled = @deck
    shuffled = @deck.shuffle

    refute_equal unshuffled, shuffled
  end
end
