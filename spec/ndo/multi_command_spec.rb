require 'spec_helper'

fail "Please copy spec/config/host.yaml.template to spec/config/host.yaml" if spec_hosts.empty?

describe Ndo::MultiCommand do
  let(:multi_cmd) { Ndo::MultiCommand.new('uname -a', %w(a b)) }
  
end

describe Ndo::MultiCommand, 'integration' do
  let(:multi_cmd) { Ndo::MultiCommand.new('cat /etc/hostname', spec_hosts) }
  
  context "result" do
    let(:result) { multi_cmd.run }
    
    spec_hosts.each do |host|
      context "[#{host.inspect}]" do
        subject { result[host] }

        it { should == host }
      end
    end
  end
end