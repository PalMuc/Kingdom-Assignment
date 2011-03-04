require 'bundler'
Bundler::GemHelper.install_tasks

task :default => [:test] do
end

desc "Run Test::Unit tests"
task :test do
  Dir["test/**/test_*.rb"].each { |test| require(File.expand_path(test)) }
end