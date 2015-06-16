module HoldEm
  class Game
    extend Forwardable

    def initialize(players)
      @table = Table.new(6)
      players.to_a.each { |player| table.seat_player(player) }
    end

    def start
      seats.each { |seat| seat.chips += 100 }
      3.times { play_round }
    end

    def play_round
      3.times { dealer.shuffle! }
      dealer.deal(seats.standard_round)

      action(seats.first_round)
      dealer.flop(board)
      action(seats.standard_round)
      dealer.turn(board)
      action(seats.standard_round)
      dealer.river(board)
      action(seats.standard_round)

      table.showdown
      table.cleanup
    end

    protected

    attr_reader :table
    def_delegators :table, :board, :dealer, :seats

    private

    def action(active_seats)
      active_seats.each { |seat| play(seat) }
    end

    def play(seat)
    end
  end
end

