require_relative 'test_helper'

class PokerRankingTest < Minitest::Test

  def test_pair
    cards = Holdem::CardGenerator.build(%w(Kd 8s 5s Kh Kc 5c Kc))
    hand = Holdem::PokerHand.new(cards)
    assert hand.pair?
    hand = Holdem::PokerHand.new(cards.first(3))
    refute hand.pair?
  end

  def test_two_pair
    cards = Holdem::CardGenerator.build(%w(7d 8s 5s 7h Kc 5c Kc))
    hand = Holdem::PokerHand.new(cards)
    assert hand.two_pairs?
  end

  def test_three_of_a_kind
    cards = Holdem::CardGenerator.build(%w(Kh Kc 5c Kc))
    hand = Holdem::PokerHand.new(cards)
    assert hand.three_of_a_kind?
    refute hand.pair?
  end

  def test_four_of_a_kind
    cards = Holdem::CardGenerator.build(%w(Ah Ac 5c 4c As Ad))
    hand = Holdem::PokerHand.new(cards)
    assert_equal true, hand.four_of_a_kind?
  end

  def test_flush?
    cards = Holdem::CardGenerator.build(%w(6c Tc 2c 4c As Ac Qh))
    hand = Holdem::PokerHand.new(cards)
    assert hand.flush?
  end

  def test_not_a_flush?
    cards = Holdem::CardGenerator.build(%w(6c Ts 2d 4c As Ac Qh))
    hand = Holdem::PokerHand.new(cards)
    refute hand.flush?
  end

  def test_for_straight?
    cards = Holdem::CardGenerator.build(%w(Td Kd Js Qd Kh Ad 9c 8c))
    hand = Holdem::PokerHand.new(cards)
    assert_equal true, hand.straight?
    hand = Holdem::PokerHand.new(cards.drop(1))
    refute hand.straight?
  end

  def test_low_ace_straight?
    cards = Holdem::CardGenerator.build(%w(2d 3s Ad 5h 4d Td 9c 8c))
    hand = Holdem::PokerHand.new(cards)
    assert_equal true, hand.straight?
  end

  def test_full_house?
    cards = Holdem::CardGenerator.build(%w(Jd 8s Jh 5h 8d Jd Tc))
    hand = Holdem::PokerHand.new(cards)
    assert_equal true, hand.full_house?
  end

  def test_straight_flush?
    cards1 = Holdem::CardGenerator.build(%w(Jd Qd Ad Kd Td 7d Tc))
    hand1  = Holdem::PokerHand.new(cards1)
    cards2 = Holdem::CardGenerator.build(%w(2d 3h 4h 5h 6h 7d 8h))
    hand2  = Holdem::PokerHand.new(cards2)
    assert hand1.straight_flush?
    refute hand2.straight_flush?
  end

  def test_alias_method_trips?
    cards = Holdem::CardGenerator.build(%w(Jd Qd Jd Jd Td 7d Tc))
    hand  = Holdem::PokerHand.new(cards)
    assert hand.trips?
  end

  def test_alias_method_quads?
    cards = Holdem::CardGenerator.build(%w(Jd Jd Jd Jd Td 7d Tc))
    hand  = Holdem::PokerHand.new(cards)
    assert hand.quads?
  end

  def test_alias_method_boat?
    cards = Holdem::CardGenerator.build(%w(Jd Jd Jd Td Td 7d 6c))
    hand  = Holdem::PokerHand.new(cards)
    assert hand.boat?
  end

end
