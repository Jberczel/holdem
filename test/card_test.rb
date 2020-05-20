require_relative 'test_helper'

class CardTest < Minitest::Test
  def setup
    @card1 = Holdem::Card.new('Kd')
    @card2 = Holdem::Card.new('Th')
    @card3 = Holdem::Card.new('4s')
    @card4 = Holdem::Card.new('7c')
  end

  def test_card_rank
    assert_equal 'K', @card1.rank
    assert_equal 'T', @card2.rank
    assert_equal '4', @card3.rank
  end

  def test_card_suit
    assert_equal 'd', @card1.suit
    assert_equal 'h', @card2.suit
    assert_equal 's', @card3.suit
    assert_equal 'c', @card4.suit
  end

  def test_card_icons
    assert_equal '♦', @card1.icon
    assert_equal '♥', @card2.icon
  end

  def test_invalid_cards
    assert_raises(ArgumentError) { Holdem::Card.new(56) }
    assert_raises(ArgumentError) { Holdem::Card.new('9k') }
    assert_raises(ArgumentError) { Holdem::Card.new('d2') }
    assert_raises(ArgumentError) { Holdem::Card.new('a card') }
  end
end
