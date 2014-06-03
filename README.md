roulette_wheel
==============

setup value and its probability, spin, and get result.

# RouletteWheel

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'roulette_wheel', github: 'shinji-yoshida/roulette_wheel', tag: 'v0.2.0'

And then execute:

    $ bundle

## Usage

    require 'roulette_wheel'

    fixed_prob_roulette = RouletteWheel.with_fixed_prob {
      pocket :foo, size: 0.1
      pocket :bar, size: 0.2
      rest :buzz
    }

    fixed_prob_roulette.has_pocket?(:foo, size: 0.1)
    #  returns true
    fixed_prob_roulette.has_pocket?(:buzz, size: 0.7)
    #  returns false. rest is not pocket.

    fixed_prob_roulette.spin
    #  returns :foo with probability 0.1, :bar with 0.2, or :buzz with 0.7

    relative_prob_roulette = RouletteWheel.with_relative_prob {
      pocket :foo, size: 2
      pocket :bar, size: 3
      pocket :buzz, size: 4
    }

    relative_prob_roulette.has_pocket?(:foo, size: 2)
    #  returns true

    relative_prob_roulette.spin
    #  returns :foo with probability 2/9, :bar with 3/9, or :buzz with 4/9

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
