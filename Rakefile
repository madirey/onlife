require './app'
require 'rake/testtask'
require 'sinatra/activerecord/rake'

desc 'Run default task'
task :default do
  ENV['RACK_ENV'] = 'test'
  Rake::Task['test'].invoke
end

desc 'Run all project tests'
Rake::TestTask.new(:test) do |t|
  t.libs << "."
  t.pattern = '*test.rb'
  t.verbose = true
end

# Load all rake tasks under lib/tasks directory
Dir.glob('lib/tasks/*.rake').each { |r| load r }
