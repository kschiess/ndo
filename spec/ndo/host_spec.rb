require 'spec_helper'

fail "Please copy spec/config/host.yaml.template to spec/config/host.yaml" if spec_hosts.empty?

require 'ndo'

describe Ndo::Host do
  let(:host) { Ndo::Host.new(spec_hosts.first) }
  
  describe '#run("uname")' do
    slet(:result) { host.run('uname -n').first.chomp }
    
    it { should == host.name }
  end
end