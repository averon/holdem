$: << File.expand_path('.')
require 'holdem'

spec_files = Dir[
  File.expand_path(File.join('.', 'spec', 'support', 'shared', '**.rb'))
]

spec_files.each do |file|
  require file
end
