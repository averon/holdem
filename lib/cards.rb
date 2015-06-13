module HoldEm
  Struct.new("Card", :value, :suit)

  class Cards
    include Enumerable
    extend Forwardable

    def_delegators :cards, :size, :pop, :clear

    def initialize(maximum_size=0)
      @cards = []
      @maximum_size = maximum_size
    end

    def each(*args, &block)
      @cards.each(*args, &block)
    end

    def <<(card)
      raise RuntimeError, "Full of Cards! #{size}/#{maximum_size}" if size >= maximum_size
      raise TypeError, "Accepts Struct::Card. You passed #{card.class}." unless card.is_a?(Struct::Card)

      @cards << card
      self
    end

    protected

    attr_reader :cards, :maximum_size
  end
end
