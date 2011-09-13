
require 'procrastinate'
require 'procrastinate/implicit'

# A class to execute a command on a list of hosts in parallel; allows access
# to results and is thus a) multi threaded and b) Ruby 1.9.2 only. 
#
class Ndo::MultiHost
  include Procrastinate

  attr_reader :hosts
  
  def initialize(hosts)
    @hosts    = hosts
  end
  
  # Runs the command on all hosts. Returns a result collection. 
  #
  def run(command)
    proxy = Procrastinate.proxy(self)

    hosts.inject(Hash.new) do |hash, host_name|
      hash[host_name] = Ndo::Result.new(
        host_name, 
        proxy.run_for_host(command, host_name))
      hash
    end
  end
  
  def run_for_host(command, host)
    begin
      Ndo::Host.new(host).run(command)
    rescue => b
      b
    end
  end
end