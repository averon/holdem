module HoldEm
  class Seat
    extend Forwardable
    attr_accessor :chips, :player
    attr_reader :pocket, :fold, :current_bet

    def initialize
      @chips = 0
      @current_bet = 0
      @fold = false
      @player = nil
      @pocket = Pocket.new
    end

    def best_hand(board)
      cards = board.to_a + pocket.to_a
      hands = cards.combination(5).map { |cards| HoldEm::Hand.new(cards) }
      hands.max
    end

    def fold!
      fold = true
    end

    def reset!
      fold = false
      current_bet = 0
      true
    end

    def bet(amount)
      raise ArgumentError, "Not enough chips #{amount}/#{chips}" if amount >= chips

      @current_bet += amount
      @chips -= amount
    end

    def active?
      player
    end

    def empty?
      !player
    end

    private

    attr_writer :current_bet
  end
end
