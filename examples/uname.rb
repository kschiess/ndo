
# Shows how to retrieve host names from multiple hosts (that we address by
# name).

$:.unshift File.dirname(__FILE__) + "/../lib"
require 'ndo'

# mh = Ndo::MultiCommand.new('uname -n', %w(hostA hostB))
mh = Ndo::MultiCommand.new('uname -n 1>&2', %w(leda kale))

results['host'].value
results['host'].success?

results = mh.run
results.each do |result|
  result.value
  result.success?
  p result
end