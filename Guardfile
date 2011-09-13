guard 'rspec', :version => 2, :cli => '--color --format doc' do
  watch(%r{^spec/.+_spec\.rb$})
  
  # Unit tests
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  
  # Acceptance
  watch(%r{^lib/})              { 'spec/acceptance'}
  
  watch('spec/spec_helper.rb')  { "spec/" }
end

