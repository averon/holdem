module HoldEm
  class Seat
    extend Forwardable
    attr_accessor :current_bet, :chips, :player
    attr_reader :pocket

    def initialize
      @chips = 0
      @current_bet = 0
      @last_action = nil
      @player = nil
      @pocket = Pocket.new
    end

    def bet(amount)
      raise ArgumentError, "Not enough chips #{amount}/#{chips}" if amount >= chips

      current_bet += amount
      chips -= amount
    end

    def active?
      player
    end

    def empty?
      !player
    end

    def reset_last_action
      last_action = nil
    end

    private
    attr_accessor :last_action
  end
end
