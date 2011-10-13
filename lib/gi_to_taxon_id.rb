require 'rubygems'
require 'sequel'

@database = Sequel.connect("jdbc:mysql://localhost/taxa?user=root")
class Protein < Sequel::Model(:proteinGiToTaxonId)
end

result =  @database[:proteingiToTaxonId].filter(:gi => 6).all
puts result.inspect

proteins = @database.from(:proteingiToTaxonId)
puts proteins.inspect

Protein.get_schema

puts Protein[8].inspect
