require_relative 'test_helper'

class PokerHandTest < Minitest::Test
  def setup
    hand1      = Holdem::CardGenerator.build(%w(4c 4h 5s Qs Jc 9c Tc))
    hand2      = Holdem::CardGenerator.build(%w(7c 4h 7s Qs Kc Qc Tc))
    hand3      = Holdem::CardGenerator.build(%w(Ac 2c 3h 4h 5s 6c Qd))
    hand4      = Holdem::CardGenerator.build(%w(Ac 9c 9h 9h 5s 6c Qd)) 
    @pair       = Holdem::PokerHand.new(hand1)
    @two_pairs  = Holdem::PokerHand.new(hand2)
    @three_kind = Holdem::PokerHand.new(hand4)
    @straight   = Holdem::PokerHand.new(hand3)
  end

  def test_poker_ranking_dependency
    assert_equal @pair.poker_rank.class, Holdem::PokerRank
  end

  def test_initialize_with_string_representation
    assert_equal 7, Holdem::PokerHand.new("Ac Ad Kd 5s 5h 4c 5c").count
  end

  def test_rank
    assert_equal "Straight", @straight.rank
  end

  def test_score
    assert_equal [2, 12, 7, 13, 10, 4], @two_pairs.score
  end

  def test_comparisons
    assert @pair < @two_pairs
    assert @pair < @straight
    assert @three_kind > @two_pairs
  end

  def test_three_kind_less_than_straight
    assert @three_kind < @straight
  end

  def test_comparison_with_kicker
    other_cards = Holdem::CardGenerator.build(%w(Ac 4c 4h 9h 6c Jh Qd)) 
    other_pair  = Holdem::PokerHand.new(other_cards)
    assert_equal [1, 4, 14, 12, 11, 9, 6], other_pair.score
    assert_equal [1, 4, 12, 11, 10, 9, 5], @pair.score
    assert  other_pair > @pair
  end

  def test_delegated_methods
    refute @pair.quads?
    refute @pair.straight_flush?
    refute @pair.trips?
    assert @pair.pair?
    assert @two_pairs.two_pairs?
    assert @straight.straight?
  end
end
