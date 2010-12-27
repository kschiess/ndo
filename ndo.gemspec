# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ndo}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kaspar Schiess"]
  s.date = %q{2010-12-27}
  s.default_executable = %q{ndo}
  s.email = %q{kaspar.schiess@absurd.li}
  s.executables = ["ndo"]
  s.extra_rdoc_files = ["README"]
  s.files = ["Gemfile", "Gemfile.lock", "LICENSE", "README", "bin", "spec", "lib/ndo", "lib/ndo/host.rb", "lib/ndo/multi_command.rb", "lib/ndo/results.rb", "lib/ndo.rb", "bin/ndo"]
  s.homepage = %q{http://blog.absurd.li}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Execute commands on multiple hosts at once.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<open4>, ["~> 1.0.1"])
      s.add_runtime_dependency(%q<procrastinate>, ["~> 0.3.0"])
      s.add_runtime_dependency(%q<text-highlight~> 1.0.2>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<flexmock>, [">= 0"])
    else
      s.add_dependency(%q<open4>, ["~> 1.0.1"])
      s.add_dependency(%q<procrastinate>, ["~> 0.3.0"])
      s.add_dependency(%q<text-highlight~> 1.0.2>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<flexmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<open4>, ["~> 1.0.1"])
    s.add_dependency(%q<procrastinate>, ["~> 0.3.0"])
    s.add_dependency(%q<text-highlight~> 1.0.2>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<flexmock>, [">= 0"])
  end
end
