$: << File.expand_path(__dir__)

def require_directory(*path_as_arguments)
  files = Dir[File.expand_path(File.join(*path_as_arguments), __dir__)]
  files.each { |file| require file }
end

require 'forwardable'
require 'singleton'

library = [
  ['lib', '**.rb'],
  ['lib', '**', '**.rb'],
  ['app', '**.rb']
]
library.each { |path_arguments| require_directory(path_arguments) }

###
players = Array.new(6) { HoldEm::Player.new }
game = HoldEm::Game.new(players)
game.start

