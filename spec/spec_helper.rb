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

def slet(sym, &block)
  let(sym, &block)
  subject { self.send(sym) }
end

def project_root
  File.expand_path(File.basename(__FILE__) + "/../")
end