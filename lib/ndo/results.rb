
class Ndo::Results
  def initialize
    @map = Hash.new
  end
  
  def [](host)
    # raise ArgumentError unless @map.has_key?(host)
    val = @map[host].value
    
    fail "INTERNAL ERROR: Child process raised an exception: #{val}." \
      unless val.kind_of?(String)
    
    val
  end
  
  include Enumerable
  def each
    @map.each { |host, _| 
      yield host, self[host] }
  end
    
  def store(host, future)
    @map.store host, future
  end
end
