
# Represents a command result for a single host. 
#
class Ndo::Result
  attr_reader :host_name
  attr_reader :future
  
  def initialize(host_name, future)
    @host_name, @future = host_name, future
  end
  
  def value
    future.value
  end
  
  def stdout
    value.first
  end
  
  def stderr
    value.last
  end
  
  def success?
    value.kind_of?(Array)
  end
  
  def exception
    value
  end
end