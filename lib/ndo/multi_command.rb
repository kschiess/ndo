
require 'ndo/results'
require 'ndo/host'
require 'procrastinate'

# A class to execute a command on a list of hosts in parallel; allows access
# to results and is thus a) multi threaded and b) Ruby 1.9.2 only. 
#
class Ndo::MultiCommand
  include Procrastinate

  attr_reader :command
  attr_reader :hosts
  
  def initialize(command, hosts)
    @command  = command
    @hosts    = hosts
  end
  
  # Runs the command on all hosts. Returns a result collection. 
  #
  def run
    scheduler = Scheduler.start(SpawnStrategy::Throttled.new(5))
    proxy = scheduler.create_proxy(self)

    Ndo::Results.new.tap { |results| 
      hosts.each { |host|
        results.store host, proxy.run_for_host(host)
      }}
  ensure
    scheduler.shutdown
  end
  
  def run_for_host(host)
    begin
      Ndo::Host.new(host).run(@command).first
    rescue => b
      "Failure: #{b}"
    end
  end
end