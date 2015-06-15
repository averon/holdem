module HoldEm
  class Game
    extend Forwardable

    def initialize(*players)
      @table = Table.new(6)
    end

    def start
      # action
      # flop
      # action
      # turn
      # action
      # river
      # winner
      # cleanup

      legacy_start
    end

    protected

    attr_reader :table
    def_delegators :table, :board, :dealer, :seats

    private

    def legacy_start
      6.times { table.seat_player(HoldEm::Player.new) }
      active_seats = seats.select { |s| s.player }

      3.times { dealer.shuffle! }
      dealer.deal(active_seats)

      dealer.flop(board)
      dealer.turn(board)
      dealer.river(board)

      players_holding = active_seats.map do |seat|
        all_cards = seat.pocket.to_a + board.to_a
        possible_hands = all_cards.combination(5).map { |cards| HoldEm::Hand.new(cards) }
        possible_hands.max
      end

      best_hand = players_holding.max
      require 'pry'; binding.pry
      puts 'bye'
    end
  end
end

