$: << File.expand_path(__dir__)

def require_directory(*path_as_arguments)
  files = Dir[File.expand_path(File.join(*path_as_arguments), __dir__)]
  files.each { |file| require file }
end

require 'forwardable'
require 'singleton'

library = [
  ['lib', '**.rb'],
  ['lib', '**', '**.rb']
]
library.each { |path_arguments| require_directory(path_arguments) }

###

table = HoldEm::Table.new
dealer = table.dealer
seats = table.seats

seats.each { |seat| seat.player = HoldEm::Player.new }
active_seats = seats.select { |s| s.player }

dealer.shuffle!
dealer.deal(active_seats)

board = dealer.flop(table.board)

players_holding = active_seats.map do |seat|
  cards = seat.pocket.to_a + board.to_a
  HoldEm::Hand.new(cards)
end

require 'pry'; binding.pry
puts 'bye'

