require 'bundler'
Bundler::GemHelper.install_tasks

task :default => [:test] do
end

#desc "Run Test::Unit tests"
#task :test do
#  Dir["test/**/test_*.rb"].each { |test| require(File.expand_path(test)) }
#end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end