module HoldEm
  class Seat
    attr_accessor :bet, :chips, :player
    attr_reader :last_action, :pocket

    VALID_ACTIONS = [:bet, :call, :check, :raise, :fold]

    def initialize
      @bet = 0
      @chips = 0
      @last_action = nil
      @player = nil
      @pocket = Pocket.new
    end

    def last_action=(action)
      raise ArgumentError, "Invalid action: #{action}" unless VALID_ACTIONS.include?(action)
      @last_action = action
    end

    def reset_last_action
      @last_action = nil
      true
    end

    def fold?
      last_action == :fold
    end
  end
end
