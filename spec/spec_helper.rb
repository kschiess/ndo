require 'yaml'

require 'ndo'

def spec_file(*names)
  File.join(
    File.dirname(__FILE__), 
    *names)
end

def spec_hosts
  YAML.load_file(spec_file('config', 'hosts.yaml'))
end