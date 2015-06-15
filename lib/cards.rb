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

  class Cards
    include Enumerable
    extend Forwardable

    def_delegators :cards, :size, :pop, :clear

    def initialize(maximum_size=0)
      @cards = []
      @maximum_size = maximum_size

      raise TypeError, "Only accepts HoldEm::Cards. Invalid card in #{cards}" unless cards.all? { |c| c.is_a?(HoldEm::Card) }
    end

    def each(*args, &block)
      @cards.each(*args, &block)
    end

    def <<(card)
      raise RuntimeError, "Full of Cards! #{size}/#{maximum_size}" if size >= maximum_size
      raise TypeError, "Accepts HoldEm::Card. You passed #{card.class}." unless card.is_a?(HoldEm::Card)

      @cards << card
      self
    end

    def claim!(cards) # TODO: Awkward: @cards + cards.cards
      raise RuntimeError, "Too many cards to add! Maximum size: #{maximum_size}" if (@cards + cards.cards).size > maximum_size
      @cards += cards.cards
      self
    end

    def to_a
      cards.dup
    end

    def to_cards
      self
    end

    protected

    attr_reader :cards, :maximum_size
  end
end
