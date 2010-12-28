require 'stringio'
require 'open4'

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
  
  def run command
    cmd = ['ssh', name, command].flatten
    result = []

    pid, inn, out, err = Open4.popen4(*cmd)

    inn.sync   = true
    streams    = [out, err]
    out_stream = {
      out => StringIO.new,
      err => StringIO.new,
    }

    # Handle process termination ourselves
    status = nil
    Thread.start do
      status = Process.waitpid2(pid).last
    end

    until streams.empty? do
      # don't busy loop
      selected, = select streams, nil, nil, 0.1

      next if selected.nil? or selected.empty?

      selected.each do |stream|
        if stream.eof? then
          streams.delete stream if status # we've quit, so no more writing
          next
        end

        data = stream.readpartial(1024)
        out_stream[stream].write data
        # 
        # if stream == err and data =~ sudo_prompt then
        #   inn.puts sudo_password
        #   data << "\n"
        #   $stderr.write "\n"
        # end

        result << data
      end
    end

    unless status.success? then
      raise ExecutionFailure.new(
        "Command failed (#{status.inspect})", 
        *streams.map { |strm| out_stream[strm].string }
      )
    end

    out_stream.map { |io, copy| copy.string }
  ensure
    inn.close rescue nil
    out.close rescue nil
    err.close rescue nil
  end
end