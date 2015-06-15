module HoldEm
  class Deck < Cards

    def_delegators :cards, :shuffle!

    def initialize
      @cards = generate
      @maximum_size = 52
    end

    private

    def generate
      HoldEm::Card::RANKS.product(HoldEm::Card::SUITS).map do |rank, suit|
        HoldEm::Card.new(rank, suit)
      end
    end
  end
end

