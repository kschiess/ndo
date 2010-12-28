
class Ndo::Results
  def initialize
    @map = Hash.new
  end
  
  def [](host)
    begin 
      val = @map[host].value
      # Swallow exception returns.
      val.instance_of?(String) ? val : nil
    rescue Procrastinate::ChildDeath
      nil
    end
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

