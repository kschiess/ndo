
class Ndo::Results
  def initialize
    @map = Hash.new
  end
  
  def [](host)
    @map[host].value
  end
  
  include Enumerable
  def each
    @map.each { |host, future| yield host, future.value }
  end
  
  def store(host, future)
    @map.store host, future
  end
end

