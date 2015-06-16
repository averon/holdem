module HoldEm
  class Card
    SUITS = [:spades, :clubs, :hearts, :diamonds]
    RANKS = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]

    attr_reader :rank, :suit

    def initialize(rank, suit)
      raise ArgumentError, "Invalid arguments: #{rank}, #{suit}" unless RANKS.include?(rank) && SUITS.include?(suit)
      @rank = rank
      @suit = suit
    end

    def value
      RANKS.index(rank)
    end

    def to_card
      self
    end
  end
end

