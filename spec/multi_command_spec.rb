
require 'spec_helper'

describe MultiCommand do
  let(:multi_cmd) { MultiCommand.new('uname -a', %w(a b)) }
  
end

describe MultiCommand, 'integration' do
  let(:multi_cmd) { MultiCommand.new('uname -a', spec_hosts) }
end