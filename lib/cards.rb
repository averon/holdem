module HoldEm
  class Cards
    include Enumerable
    extend Forwardable

    def_delegators :cards, :size, :pop, :clear, :empty?

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
