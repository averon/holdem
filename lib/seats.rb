module HoldEm
  class Seats
    include Enumerable

    def initialize(seats)
      @seats = seats
      @button = 0
    end

    def seat_player(player, seat_index=nil)
      raise RuntimeError, "All seats are full." if seats.all? { |seat| seat.player }
      raise ArgumentError, "Invalid seat index: #{seat_index} out of range (0..#{seats.size})" unless (0..seats.size).include?(seat_index.to_i)
      raise ArgumentError, "Seat #{seat_index} is currently occupied by player #{seats[seat_index].player}" if seat_index && seats[seat_index].player
      raise ArgumentError, "Cannot seat player: #{player}" unless player.is_a?(HoldEm::Player)

      seat_index ||= seats.find_index { |seat| seat.empty? }
      seats[seat_index].player = player
      true
    end

    def unseat_player(player)
      seat = seats.find { |seat| seat.player == player }
      seat.player = nil
      true
    end

    def move_button!
      button = button_index(button + 1)
    end

    def standard_round
      active_seats.drop(small_blind) + active_seats.take(small_blind)
    end

    def first_round
      first_action = button_index(big_blind + 1)
      active_seats.drop(first_action) + active_seats.take(first_action)
    end

    def all
      seats.dup
    end

    def each(*args, &block)
      seats.each(*args, &block)
    end

    def to_play
      seats.max { |seat| seat.current_bet }.current_bet
    end

    def active_seats
      seats.select { |seat| seat.player }
    end
    alias_method :active, :active_seats

    private

    def big_blind
      button_index(button + 2)
    end

    def small_blind
      button_index(button + 1)
    end

    def button_index(int)
      int % active_seats.size
    end

    attr_reader :seats
    attr_accessor :button
  end
end
