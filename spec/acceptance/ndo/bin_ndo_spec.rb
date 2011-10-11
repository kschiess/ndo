require 'spec_helper'

fail "Please copy spec/config/host.yaml.template to spec/config/host.yaml" if spec_hosts.empty?

describe "bin/ndo" do
  let(:binary) { File.join(project_root, 'bin/ndo') } 
  
  PipeFD = Struct.new(:r, :w)
  def pipe
    PipeFD.new(*IO.pipe)
  end
  
  it "receives hosts from stdin when host_set is '-'" do
    i = pipe
    o = pipe

    pid = Process.spawn(
      binary + " - uname", 
      :in => i.r,
      :out => o.w,
      :err => o.w)
    
    # Feed all hosts on stdin
    spec_hosts.each { |name| i.w.puts(name) }
    
    # Close stdin
    i.w.close

    # Wait for process
    Process.waitall

    # Now read its stdout: 
    output = o.r.read_nonblock(1000)
    
    spec_hosts.each do |host_name|
      output.should include(host_name)
    end
  end
end