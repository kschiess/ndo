require "rubygems"
require "rubygems/package_task"
require "rdoc/task"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

# This task actually builds the gem. 
task :gem => :spec
spec = eval(File.read('ndo.gemspec'))

desc "Generate the gem package."
Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

# Generate documentation
RDoc::Task.new do |rd|
  rd.main = "README"
  rd.rdoc_files.include("README", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package] do
  rm "#{spec.name}.gemspec"
end

desc "Build manual"
task :build_man do
  sh "ronn -br5 man/*.ronn"
end