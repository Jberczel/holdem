module Holdem
  class PokerRank
    attr_reader :cards, :score, :rank

    def initialize(cards)
      @cards = cards
      @score, @rank = build_ranking
    end

    def build_ranking
      case 
        when straight_flush?   then build_straight_flush
        when four_of_a_kind?   then build_four_kind
        when full_house?       then build_full_house
        when flush?            then build_flush
        when straight?         then build_straight
        when three_of_a_kind?  then build_three_kind
        when two_pairs?        then build_two_pairs
        when pair?             then build_pair
        else
          build_high_card
      end
    end

  # POKER HAND RANKINGS
  # These methods determine type of poker hand. Hands are sorted by pair, then by
  # values in descending order using the #pairs method.  The hand ranking methods
  # below filter the pairs array to determine type of hand.

    def straight_flush?
      sorted_cards.each_cons(5) do |check_cards|
        return true if five_card_straight?(check_cards.map(&:value)) && check_cards.map(&:suit).uniq.one?
      end
      false
    end

    def four_of_a_kind?
      kinds?(4)
    end

    def full_house?
      three_of_a_kind? && pair?
    end

    def flush?
      suits.any? { |_,count| count >= 5 }
    end

    def straight?
      card_values = sorted_values
      # check for low ace straight
      card_values.push(1) if card_values.include?(14)
      card_values.each_cons(5) do |vals|
        return true if five_card_straight?(vals)
      end
      false
    end

    def five_card_straight?(list)
      (list.first - list.last).abs == 4 && list.uniq.length == 5
    end

    def three_of_a_kind?
      kinds?(3)
    end

    def two_pairs?
      num_of_pairs = pairs.select { |count,_cards| count == 2 }.size
      num_of_pairs > 1
    end

    def pair?
      kinds?(2)
    end

    def kinds?(size)
      pairs.any? { |count,_cards| count == size }
    end

    alias_method :quads?, :four_of_a_kind?
    alias_method :trips?, :three_of_a_kind?
    alias_method :boat?, :full_house?
    alias_method :two_pair?, :two_pairs?


  # BUILD HAND RANKINGS
  # Score are first ranked by type of hand [0-9].  If equal, then compared by pairs, 
  # high cards, and/or remaining cards.  Also includes description of hand.

    def build_high_card
      [ [0] + sorted_values, "#{high_card.rank} high" ]
    end

    def build_pair
      [ [1] + pair_card_values, "Pair of #{pair_card.rank}s" ]
    end

    def build_two_pairs
      [ [2] + pair_card_values,
        "Two Pairs (#{pair_card(1).rank}s and #{pair_card(2).rank}s)",
      ]
    end

    def build_three_kind
      [ [3] + pair_card_values, "Three of a Kind (trip #{pair_card.rank}s)" ]
    end

    def build_straight
      [ [4, highest_straight_card], "Straight" ]
    end

    def build_flush
      [ [5, highest_flush_card], "Flush" ]
    end

    def build_full_house
      [ [6] + pair_card_values, 
        "Full House (#{pair_card(1).rank}s over #{pair_card(2).rank}s)",    
      ]
    end

    def build_four_kind
      [ [7] + pair_card_values, 
        "Four of a kind (quad #{pair_card(1).rank}s)",
      ]
    end

    def build_straight_flush
      [ [8, highest_straight_card], "Straight Flush" ]
    end

    # HELPER METHODS
    def high_card
      sorted_cards.first
    end

    def highest_straight_card
      sorted_values.each_cons(5) do |vals|
        return vals.first if five_card_straight?(vals)
      end
    end

    def highest_flush_card
      cards.select { |card| card.suit == flush_suit }.max.value
    end

    def flush_suit
      suit, count = suits.first
      return suit if count >= 5 
    end

    private

    # helper method to retrieve card value/rank for each pair
    def pair_card(num=1)
      pairs.take(num).map { |_count, cards| cards.last }.last
    end

    # helper method to calculate poker scores
    def pair_card_values
      pairs.map { |_count, cards| cards.first.value }
    end

    def sorted_cards
      @sorted_cards ||= cards.sort_by { |card| card.value * -1 }
    end

    def pairs
      @pairs ||= cards.group_by { |card| card.value }
                      .map { |_val,cards| [cards.count, cards] }
                      .sort_by { |count,cards| [count*-1, cards.first.value*-1] }
    end

    def suits
      @suits ||= cards.group_by { |card| card.suit }
                      .map { |k,v| [k, v.count] }
                      .sort_by { |k,count| [count*-1] }
    end

    def sorted_values
      @sorted_values ||= sorted_cards.map(&:value)
    end
  end
end




