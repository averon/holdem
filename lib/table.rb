module HoldEm
  class Table
    extend Forwardable

    attr_reader :board, :dealer, :seats

    def_delegators :dealer, :deck
    def_delegators :seats, :seats, :seat_player, :unseat_player, :standard_round, :first_round, :move_button!

    def initialize(seats=6)
      @board = Board.new
      @dealer = Dealer.new
      @pot = 0
      @seats = Seats.new(Array.new(seats) { Seat.new })
      @min_bet = 10
    end

    def place_blinds
      seats.standard_round[0].chips -= min_bet
      seats.standard_round[1].chips -= min_bet * 2
      @pot += min_bet * 3
      true
    end

    def showdown
      # TODO: Split pot
      award_winnings(winner)
    end

    def cleanup
      seats.each do |seat|
        return_to_deck(seat.pocket)
        seat.reset!
      end
      return_to_deck(dealer.burn)
      return_to_deck(board)

      raise RuntimeError, "Cleanup failed! #{deck.size}/52 cards found" unless deck.size == 52
      raise RuntimeError, "Cleanup failed! The pot has #{@pot} left over" unless @pot == 0 # TODO: Split pots.
      raise RuntimeError, "Cleanup failed! A player left chips on the table" unless seats.all? { |seat| seat.current_bet == 0 }
    end

    private

    attr_reader :seats, :min_bet

    def winner
      best_hand = seats.active.map { |seat| seat.best_hand(board) }.max
      seats.active.find { |seat| seat.best_hand(board) == best_hand }
    end

    def award_winnings(winner)
      winner.chips += @pot
      @pot = 0
      winner
    end

    def return_to_deck(cards)
      deck.claim!(cards)
      cards.clear
      true
    end
  end
end
