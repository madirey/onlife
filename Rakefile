require 'rake/testtask'

task :default do
  ENV['RACK_ENV'] = 'test'
  Rake::Task['test'].invoke
end

Rake::TestTask.new(:test) do |t|
  t.libs << "."
  t.pattern = '*test.rb'
  t.verbose = true
end
