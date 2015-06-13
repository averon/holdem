module HoldEm
  class Dealer
    attr_reader :deck, :burn

    def initialize
      @deck = Deck.new
      @burn = Cards.new(3)
    end

    def deal(seats)
      2.times do
        seats.each do |seat|
          seat.pocket << deck.pop
        end
      end
    end

    def flop(board)
      burn << deck.pop
      3.times { board << deck.pop }
    end

    def turn(board)
      burn << deck.pop
      board << deck.pop
    end

    def river(board)
      burn << deck.pop
      board << deck.pop
    end

    def shuffle!
      deck.shuffle!
    end
  end
end
