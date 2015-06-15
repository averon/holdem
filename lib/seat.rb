module HoldEm
  class Seat
    extend Forwardable
    attr_accessor :bet, :chips, :player
    attr_reader :pocket

    def initialize
      @bet = 0
      @chips = 0
      @player = nil
      @pocket = Pocket.new
    end

    def empty?
      !player
    end
  end
end
