require 'rubygems'
require 'bio'

puts Bio::NCBI::REST.efetch("270016927", {"db"=>"protein", "retmode"=>"xml", "email"=>"ncbi@volton.otherinbox.com"})