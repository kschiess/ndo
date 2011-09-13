
# Shows how to retrieve host names from multiple hosts (that we address by
# name).

$:.unshift File.dirname(__FILE__) + "/../lib"
require 'ndo'

# mh = Ndo::MultiCommand.new('uname -n', %w(hostA hostB))
mh = Ndo::MultiCommand.new('date', %w(leda)*10)

loop do
  results = mh.run
  results.each do |host, result|
    [host, result]
  end
end