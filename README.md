# Holdem

A ruby module for creating and comparing Texas Holdem poker hands.

## Installation

Add this line to your application's Gemfile:

    gem 'holdem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install holdem

## Example

    require 'holdem'

    deck = Holdem::Deck.new
    deck.shuffle!

    hand1 = Holdem::PokerHand.new(deck.deal(7))
    hand2 = Holdem::PokerHand.new(deck.deal(7))
    hand3 = Holdem::PokerHand.new("4c Kc 4h 5d 6s Kd Qs")

    puts hand1                     # => 5♦ K♣ T♠ J♥ 8♥ 8♠ 2♥ -> Pair of 8s
    puts hand2                     # => Q♦ 6♦ 2♦ 6♣ 5♥ 6♠ T♦ -> Three of a Kind (trip 6s)
    puts hand3                     # => 4♣ K♣ 4♥ 5♦ 6♠ K♦ Q♠ -> Two Pairs (Ks and 4s)

    puts hand1 > hand2             # => false
    puts hand2 < hand3             # => false
    puts [hand1, hand2, hand3].max # => Q♦ 6♦ 2♦ 6♣ 5♥ 6♠ T♦ -> Three of a Kind (trip 6s)


## Usage

Cards can be passed to the PokerHand constructor as a string of card representations
or as an array of card objects.  

Face cards (ten, jack, queen, king, and ace) are represented by (T, J, Q, K, A).

Suits (club, diamond, spade, heart) are represented by (c, d, s, h).
    
    puts Holdem::PokerHand.new('Ac 7d 4c Td Qc Qh Ks')     # => A♣ 7♦ 4♣ T♦ Q♣ Q♥ K♠ -> Pair of Qs

    card1, card2 = Card.new('Ad'), Card.new('Ah')     
    puts Holdem::PokerHand.new([card1, card2])             # => A♦ A♥ -> Pair of As

There is also a Deck class to facilitate random poker hands:
    
    deck  = Holdem::Deck.new.shuffle!
    cards = deck.deal(7)
    hand  = Holdem::PokerHand.new(cards)
    puts hand    # => K♦ 5♣ 4♣ 8♣ J♠ 3♣ 7♦ -> K high

A number of ranks can be asked about a hand:

    hand.straight_flush?
    hand.quads?           # or hand.four_of_a_kind?
    hand.boat?            # or hand.full_house?
    hand.flush?
    hand.straight?
    hand.trips?           # or hand.three_of_a_kind? 
    hand.two_pairs?
    hand.pair?

## TODO

Build Simulations, players, table, chips, and game objects.

Add methods to PokerRank for:

    hand.open_ended?
    hand.four_to_flush?
    hand.gutshot?


## Contributing

1. Fork it ( https://github.com/[my-github-username]/holdem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
