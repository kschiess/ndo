
# A collection of results. 
#
class Ndo::Results
  def self.acquire(command, hosts)
    results = new(command, hosts)
    results.acquire
  end
  
  def initialize(command, hosts)
    @opts = {
      :workers => 10
    }
  end
  
  def [](host)
    ''
  end
end