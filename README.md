# Holdem

A ruby module for creating and comparing Texas Holdem poker hands.

## Installation

Add this line to your application's Gemfile:

    gem 'holdem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install holdem

## Usage

    require 'holdem'

    deck = Deck.new
    deck.shuffle!

    hand1 = PokerHand.new(deck.deal(7))
    hand2 = PokerHand.new(deck.deal(7))
    hand3 = PokerHand.new("4c Kc 4h 5d 6s Kd Qs")

    puts hand1                     # => 5♦ K♣ T♠ J♥ 8♥ 8♠ 2♥ -> Pair of 8s
    puts hand2                     # => Q♦ 6♦ 2♦ 6♣ 5♥ 6♠ T♦ -> Three of a Kind (trip 6s)
    puts hand3                     # => 4♣ K♣ 4♥ 5♦ 6♠ K♦ Q♠ -> Two Pairs (Ks and 4s)

    puts hand1 > hand2             # => false
    puts hand2 < hand3             # => false
    puts [hand1, hand2, hand3].max # => Q♦ 6♦ 2♦ 6♣ 5♥ 6♠ T♦ -> Three of a Kind (trip 6s)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/holdem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
