module HoldEm
  class Deck < Cards

    def_delegators :cards, :shuffle!

    def initialize
      @cards = generate
      @maximum_size = 52
    end

    def reclaim(cards) # TODO: Better name.
      raise RuntimeError, "Too many cards to add! Maximum size: #{maximum_size}" if (@cards + cards.cards).size > maximum_size
      @cards += cards.cards
      self
    end

    private

    def generate
      values = (2..10).to_a + [:J, :Q, :K, :A]
      suits = [:spades, :clubs, :hearts, :diamonds]
      values.product(suits).map do |card|
        Struct::Card.new(*card)
      end
    end
  end
end

