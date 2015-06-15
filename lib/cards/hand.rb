def HoldEm::Hand(*handable)
  cards = HoldEm::Cards.new(5)

  handable.each do |card|
    next cards.claim!(card.to_cards) if card.respond_to?(:to_cards)
    next cards << card.to_card if card.respond_to?(:to_card)
    next cards << HoldEm::Card.new(*card.to_a) if card.respond_to?(:to_a)
    raise ArgumentError, "Invalid argument: #{card}"
  end

  HoldEm::Hand.new(cards)
end

module HoldEm
  class Hand < Cards
    include Comparable

    def initialize(cards)
      @cards = cards.to_a
      @maximum_size = 5
      @rules = HoldEm::Rules::Hands.instance

      raise StandardError, "Invalid number of cards. #{cards.size}/#{maximum_size}" unless cards.size == maximum_size
    end

    def <=>(other)
      self.value <=> other.value
    end

    def value
      @value ||= evaluate(self)
    end

    private

    attr_accessor :rules

    def_delegators :rules, :evaluate
  end
end
