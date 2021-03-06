
module Ndo
  Process = Struct.new(:pid, :stdin, :stdout, :stderr) do
    def status
      wait unless @status
      @status
    end
    def wait
      _, @status = ::Process.waitpid2(pid)
    end
    def success?
      status.success?
    end
    def close_all
      [stdin, stdout, stderr].
        each(&:close)
    end
  end
  
  Pipe = Struct.new(:read, :write)
  
  # NOTE: This was using the Open4 gem previously. That method turned out to
  # not be portable across rubies and operating systems, that's why we try
  # our luck with maintaining this popen4 here. 
  #
  def popen(*cmd)
    c_in, c_out, c_err = 3.times.map { Pipe.new(*IO.pipe) }

    pid = fork do
      c_in.write.close
      STDIN.reopen(c_in.read)
      c_in.read.close
      
      c_out.read.close
      STDOUT.reopen(c_out.write)
      c_out.write.close
      
      c_err.read.close
      STDERR.reopen(c_err.write)
      c_err.write.close
      
      exec(*cmd)
      fail "NOT REACHED: EXEC FAILED"
    end

    c_in.read.close
    c_out.write.close
    c_err.write.close
    
    # c_in.sync = true
    Process.new(pid, c_in.write, c_out.read, c_err.read)
  end
  module_function :popen
end