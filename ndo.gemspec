# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ndo}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kaspar Schiess"]
  s.date = %q{2010-12-29}
  s.default_executable = %q{ndo}
  s.email = %q{kaspar.schiess@absurd.li}
  s.executables = ["ndo"]
  s.extra_rdoc_files = ["README"]
  s.files = %w(Gemfile HISTORY.txt LICENSE Rakefile README) + Dir.glob("{lib,examples,bin}/**/*")
  s.homepage = %q{http://blog.absurd.li}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Execute commands on multiple hosts at once.}

  s.add_dependency(%q<procrastinate>, ["~> 0.3"])
  s.add_dependency(%q<text-highlight>, ["~> 1.0"])
  
  s.add_development_dependency(%q<rspec>, [">= 0"])
  s.add_development_dependency(%q<flexmock>, [">= 0"])
end
