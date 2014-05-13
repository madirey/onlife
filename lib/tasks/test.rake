# Rake tasks for OnLife assignment tests
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'sinatra/activerecord/rake'

namespace :test do

  desc 'Run model tests'
  RSpec::Core::RakeTask.new(:models)

  desc 'Run application tests'
  Rake::TestTask.new(:app) do |t|
    t.libs << "."
    t.pattern = '*test.rb'
    t.verbose = true
  end

  desc 'Run all tests'
  task :all => [:models, :app]

end
