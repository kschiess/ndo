
# A class to execute a command on a list of hosts in parallel; allows access
# to results and is thus a) multi threaded and b) Ruby 1.9.2 only. 
#
class Ndo::MultiCommand
  attr_reader :command
  attr_reader :hosts
  
  def initialize(command, hosts)
    @command  = command
    @hosts    = hosts
  end

  # Runs the command on all hosts. Returns a result collection. 
  #
  def run
    Ndo::Results.acquire(command, hosts)
  end
end