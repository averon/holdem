module HoldEm::Rules
  class Hands
    include Singleton

    def evaluate(hand)
      raise ArgumentError, "Invalid hand: #{hand}" unless hand.is_a?(HoldEm::Hand)

      made_hand = rankify(hand)
      hand_rank = ranks.index(made_hand)
      card_values = hand.inject(0) { |sum, card| sum + card.value }
      matched_values = matched_cards(hand).inject(0) { |sum, group| sum + group.first.value }

      hand_rank * 100_000 + matched_values * 100 + card_values
    end

    private

    def ranks
      [
        :high_card,
        :one_pair,
        :two_pair,
        :three_of_a_kind,
        :straight,
        :flush,
        :full_house,
        :four_of_a_kind,
        :straight_flush
      ]
    end


    def rankify(hand) # TODO: Optimize helper methods for speed if necessary.
      case hand
      when ->(hand) { straight_flush?(hand)  } then :straight_flush
      when ->(hand) { four_of_a_kind?(hand)  } then :four_of_a_kind
      when ->(hand) { full_house?(hand)      } then :full_house
      when ->(hand) { flush?(hand)           } then :flush
      when ->(hand) { straight?(hand)        } then :straight
      when ->(hand) { three_of_a_kind?(hand) } then :three_of_a_kind
      when ->(hand) { two_pair?(hand)        } then :two_pair
      when ->(hand) { one_pair?(hand)        } then :one_pair
      else :high_card
      end
    end

    def straight_flush?(hand)
      straight?(hand) && flush?(hand)
    end

    def four_of_a_kind?(hand)
      matched_cards_count(hand) == [4]
    end

    def full_house?(hand)
      matched_cards_count(hand).sort == [2, 3]
    end

    def flush?(hand)
      hand.map(&:suit).uniq.one?
    end

    def straight?(hand)
      sorted = hand.sort { |c1, c2| c1.value <=> c2.value }
      maybe_ace = sorted.pop.value if sorted.first.rank == :two && sorted.last.rank == :ace
      min, max = [sorted.first, sorted.last]

      Array(maybe_ace) + Array(min.value..max.value) == hand.map(&:value).sort
    end

    def three_of_a_kind?(hand)
      matched_cards_count(hand) == [3]
    end

    def two_pair?(hand)
      matched_cards_count(hand) == [2, 2]
    end

    def one_pair?(hand)
      matched_cards_count(hand) == [2]
    end

    def matched_cards(hand)
      grouped_by_rank(hand).select { |group| group.count > 1 }
    end

    def matched_cards_count(hand)
      matched_cards(hand).map { |group| group.count }
    end

    def grouped_by_rank(hand)
      unique_ranks = hand.map(&:rank).uniq
      unique_ranks.map do |rank_to_match|
        hand.select { |card| card.rank == rank_to_match }
      end
    end
  end
end
