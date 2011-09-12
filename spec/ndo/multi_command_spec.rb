require 'spec_helper'

fail "Please copy spec/config/host.yaml.template to spec/config/host.yaml" if spec_hosts.empty?

describe Ndo::MultiCommand do
  let(:multi_cmd) { Ndo::MultiCommand.new('uname -a', %w(a b)) }
  
end

describe Ndo::MultiCommand, 'integration' do
  
  context "when the command suceeds (spec_hosts)" do
    let(:multi_cmd) { Ndo::MultiCommand.new('cat /etc/hostname', spec_hosts) }
    let(:result) { multi_cmd.run }

    spec_hosts.each do |host|
      context "[#{host.inspect}]" do
        subject { result[host].chomp }

        it { should == host }
      end
    end
  end
  context "when the command fails" do
    let(:multi_cmd) { Ndo::MultiCommand.new('failing command', %w(unknown)) }
    
    context "result['unknown']" do
      subject { multi_cmd.run['unknown'] }
      
      it { should be_nil }
    end
  end
end