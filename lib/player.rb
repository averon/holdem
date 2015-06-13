module HoldEm
  class Player
    attr_reader :bankroll

    def initialize
      @bankroll = Bankroll.new
    end
  end
end

