# encoding: UTF-8

require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
  t.rspec_opts = '--color --order random'
end

task default: :spec
