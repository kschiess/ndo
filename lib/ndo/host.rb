require 'stringio'

# Runs a command via ssh on a host. This is initially stolen from vlad (the
# deployer), then rewritten and modified. 
#
class Ndo::Host
  attr_reader :name
  def initialize(hostname)
    @name = hostname
  end
  
  class ExecutionFailure < StandardError
    def initialize(message=nil, stdout=nil, stderr=nil)
      super(message)
      @stdout, @stderr = stdout, stderr
    end
    
    attr_reader :stdout, :stderr
    
    def to_s
      super + "\nstdout: #{stdout}\nstderr: #{stderr}"
    end
  end
  
  class Accumulator
    attr_reader :buffer
    
    def initialize(stream)
      @stream = stream
      @buffer = ''
      @eof = false
    end
    
    def copy_if_ready(ready_list)
      return unless ready_list.include?(@stream)
      
      @buffer << @stream.read_nonblock(1024)
    rescue EOFError
      @eof = true
    end
    
    def eof?
      @eof
    end
  end
  
  def run(command)
    cmd = ['ssh', name, command].flatten
    
    process = Ndo.popen(*cmd)
    accums = [
      Accumulator.new(process.stdout), 
      Accumulator.new(process.stderr)]
    
    # Copy stdout, stderr to buffers
    loop do
      ios = [process.stdout, process.stderr]
      ready,_,_ = IO.select(ios)
      
      # Test for process closed
      break if accums.any? { |acc| acc.eof? }
      
      # Copy data
      accums.each { |acc| acc.copy_if_ready(ready) }
    end
    
    # We're done reading: prepare return value
    buffers = accums.map { |acc| acc.buffer  }
    
    process.wait 
    
    # Raise ExecutionFailure if the command failed
    unless process.success?
      status = process.status
      raise ExecutionFailure.new(
        "Command failed (#{status.inspect})", 
        *buffers
      )
    end
    
    # Return [STDOUT, STDERR] buffers
    buffers
  ensure
    process.close_all
  end
end