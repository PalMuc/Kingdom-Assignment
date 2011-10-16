# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kingdom-assignment/version"

Gem::Specification.new do |s|
  s.name        = "kingdom-assignment"
  s.version     = Kingdom::Assignment::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Philipp Comans"]
  s.email       = ["kingdom-assignment@volton.otherinbox.com"]
  s.homepage    = "http://www.mol-palaeo.de/"
  s.summary     = %q{A Ruby gem to parse BLASTplus XML output and annotate higher rank taxonomy}
  s.description = %q{Kingdom-Assignment is a tool to parse the NCBI BLASTplus XML format output and store attributes of BLASTplus in tabular form as a CSV file.}
  
  if RUBY_PLATFORM =~ /java/
    s.add_dependency "jdbc-mysql", "~> 5.1.13"
  else
  	s.add_dependency "mysql", "~> 2.8.1"
  end

  s.add_dependency "sequel", "~> 3.28.0"

  s.add_dependency "fastercsv", "~> 1.5.4" #only used on Ruby < 1.9

  s.add_dependency "nokogiri", "~> 1.5.0"
  s.add_dependency "bio", "~> 1.4.2"
  s.add_dependency "trollop", "~> 1.16.2"

  s.rubyforge_project = "kingdom-assignment"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
