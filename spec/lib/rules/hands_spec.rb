require 'spec_helper'

describe HoldEm::Rules::Hands do
  include_context 'Example Hands'

  subject { described_class.instance }

  describe '#evaluate(hand)' do
    context 'when passed a valid' do
      describe 'straight flush' do
        let(:cards) { EXAMPLE_HANDS[:straight_flush] }

        it 'has score 7xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(8)
        end
      end

      describe 'four of a kind' do
        let(:cards) { EXAMPLE_HANDS[:four_of_a_kind] }

        it 'is has score 6xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(7)
        end
      end

      describe 'full house' do
        let(:cards) { EXAMPLE_HANDS[:full_house] }

        it 'has score 5xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(6)
        end
      end

      describe 'flush' do
        let(:cards) { EXAMPLE_HANDS[:flush] }

        it 'has score 4xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(5)
        end
      end

      describe 'straight' do
        let(:cards) { EXAMPLE_HANDS[:straight] }

        it 'has score 3xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(4)
        end
      end

      describe 'three of a kind' do
        let(:cards) { EXAMPLE_HANDS[:three_of_a_kind] }

        it 'has score 2xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(3)
        end
      end

      describe 'two pair' do
        let(:cards) { EXAMPLE_HANDS[:two_pair] }

        it 'has score 1xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(2)
        end
      end

      describe 'one pair' do
        let(:cards) { EXAMPLE_HANDS[:one_pair] }

        it 'has score 0xx' do
          expect(subject.evaluate(HoldEm::Hand(*cards)) / 100_000).to eq(1)
        end
      end
    end

    context 'when passed an invalid hand' do
      it 'fails'
    end
  end
end
