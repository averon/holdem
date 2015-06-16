module HoldEm
  class Table
    extend Forwardable

    attr_reader :board, :dealer, :pot, :seats

    def_delegators :dealer, :deck
    def_delegators :seats, :seats, :seat_player, :unseat_player, :standard_round, :first_round, :move_button!

    def initialize(seats=6)
      @board = Board.new
      @dealer = Dealer.new
      @pot = 0
      @seats = Seats.new(Array.new(seats) { Seat.new })
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
      raise RuntimeError, "Cleanup failed! A player left chips on the table" unless seats.all? { |seat| seat.current_bet == 0 }
    end

    private

    attr_reader :seats

    def winner
      # TODO: Implement
      seats.select(&:active?).sample
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
