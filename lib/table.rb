module HoldEm
  class Table
    extend Forwardable

    attr_reader :board, :dealer, :pot

    def_delegators :dealer, :deck

    def initialize(seats=6)
      @board = Board.new
      @dealer = Dealer.new
      @pot = 0
      @seats = Array.new(seats) { Seat.new }
    end

    def seat_player(player, seat=nil)
      raise ArgumentError, "Cannot seat player: #{player}" unless player.is_a?(HoldEm::Player)
      raise ArgumentError, "Seat #{seat} is currently occupied" if seat && seats[seat] && seats[seat].player
      raise RuntimeError, "All seats are full." unless seats.any? { |seat| seat.empty? }

      seat ||= seats.find_index { |seat| seat.empty? }
      seats[seat].player = player
      true
    end

    def unseat_player(player)
      seat = seat.find { |seat| seat.player == player }
      seat.player = nil
      true
    end

    def showdown
      # TODO: Split pot
      award_winnings(winner)
    end

    def cleanup
      seats.each do |seat|
        return_to_deck(seat.pocket)
        seat.reset_last_action
      end
      return_to_deck(dealer.burn)
      return_to_deck(board)

      raise RuntimeError, "Cleanup failed! #{deck.size}/52 cards found" unless deck.size == 52
      raise RuntimeError, "Cleanup failed! The pot has #{pot} left over" unless pot == 0 # TODO: Split pots.
      raise RuntimeError, "Cleanup failed! A player left chips on the table" unless seats.all? { |seat| seat.bet == 0 }
    end

    private

    attr_reader :seats

    def winner
      # TODO: Implement
      seats.select(&:player).reject(&:fold?).sample
    end

    def award_winnings(winner)
      winner.chips += pot
      pot = 0
      winner
    end

    def return_to_deck(cards)
      deck.claim!(cards)
      cards.clear
      true
    end
  end
end
