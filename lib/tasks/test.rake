# Rake tasks for OnLife assignment tests

namespace :test do

  desc 'Run model tests'
  RSpec::Core::RakeTask.new(:models)

  desc 'Run application tests'
  Rake::TestTask.new(:app) do |t|
    Rake::Task['prepare']
    t.libs << "."
    t.pattern = '*test.rb'
    t.verbose = true
  end

  desc 'Run all tests'
  task :all => [:models, :app]

end
