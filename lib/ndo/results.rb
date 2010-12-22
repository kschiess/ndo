
class Ndo::Results
  def initialize
    @map = Hash.new
  end
  
  def [](host)
    @map[host].value
  end
  
  include Enumerable
  def each
    @map.each { |host, future| 
      begin
        yield host, future.value
      rescue Procrastinate::ChildDeath
        
      end }
  end
  
  def store(host, future)
    @map.store host, future
  end
end

