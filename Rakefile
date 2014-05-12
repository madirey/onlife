require './app'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'sinatra/activerecord/rake'

desc 'Run default task'
task :default do
  Rake::Task['test'].invoke
end

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

# Load all rake tasks under lib/tasks directory
Dir.glob('lib/tasks/*.rake').each { |r| load r }
