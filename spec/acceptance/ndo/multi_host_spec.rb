require 'spec_helper'

fail "Please copy spec/config/host.yaml.template to spec/config/host.yaml" if spec_hosts.empty?

describe Ndo::MultiHost, 'integration' do
  
  context "when the command succeeds (spec_hosts)" do
    let(:command) { 'cat /etc/hostname' }
    let(:multi_cmd) { described_class.new(spec_hosts) }
    let(:results) { multi_cmd.run(command) }

    spec_hosts.each do |host|
      context "[#{host.inspect}]" do
        let(:result) { results[host] }
        
        it "should have a correct result structure" do
          result.host_name.should == host
          
          result.value.first.chomp.should == host
          result.value.last.should == ''
          
          result.stdout.chomp.should == host
          
          result.stderr.should == ''
          
          result.should be_a_success
        end 
      end
    end
  end
  context "when the command fails" do
    let(:multi_cmd) { described_class.new(%w(unknown)) }
    
    context "result['unknown']" do
      slet(:result) { multi_cmd.run('failing')['unknown'] }
      
      it { should_not be_success }
    end
  end
end