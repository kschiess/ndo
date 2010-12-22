require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

require 'rspec'
require 'rspec/core/rake_task'
Rspec::Core::RakeTask.new
task :default => :spec

# This builds the actual gem. For details of what all these options
# mean, and other ones you can add, check the documentation here:
#
#   http://rubygems.org/read/chapter/20
#
spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "ndo"
  s.version           = "0.1.0"
  s.summary           = "Execute commands on multiple hosts at once."
  s.author            = "Kaspar Schiess"
  s.email             = "kaspar.schiess@absurd.li"
  s.homepage          = "http://blog.absurd.li"

  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(README)
  s.rdoc_options      = %w(--main README)

  # Add any extra files to include in the gem
  s.files             = %w(Gemfile Gemfile.lock LICENSE README) + Dir.glob("{bin,spec,lib/**/*}")
  s.executables       = FileList["bin/**"].map { |f| File.basename(f) }
  s.require_paths     = ["lib"]

  s.add_dependency 'open4',          '~> 1.0.1'
  s.add_dependency 'procrastinate',  '~> 0.2.0'
  s.add_dependency 'text-highlight'

  s.add_development_dependency("rspec")
  s.add_development_dependency("flexmock")
end

# This task actually builds the gem. We also regenerate a static
# .gemspec file, which is useful if something (i.e. GitHub) will
# be automatically building a gem for this project. If you're not
# using GitHub, edit as appropriate.
#
# To publish your gem online, install the 'gemcutter' gem; Read more 
# about that here: http://gemcutter.org/pages/gem_docs
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

task :package => :gemspec

# Generate documentation
Rake::RDocTask.new do |rd|
  rd.main = "README"
  rd.rdoc_files.include("README", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end
