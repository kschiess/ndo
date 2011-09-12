require 'spec_helper'

describe "Ndo.popen" do
  it "execute a command" do
    process = Ndo.popen('echo test')
    
    process.status.should be_success
    process.stdout.read.should == "test\n"
  end
  
  describe 'result' do
    slet(:result) { Ndo.popen('echo test') }
    
    it { should be_success }
    describe '#status' do
      it "can be accessed multiple times" do
        result.status.should be_success
        result.status.should be_success
      end 
    end 
  end
end