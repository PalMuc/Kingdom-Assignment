require 'rubygems'
require 'kingdom_db'

db = KingdomDB.new('localhost', 'root', '', 'ncbi_taxonomy')

species_name = "Phage phiJL001"
current_species_id = db.id_from_name(species_name)
puts "Hello"
while (current_species_id.to_i > KingdomDB::ROOT_ID.to_i)
  puts current_species_id.to_s + ": " + db.node_rank_from_id(current_species_id) + ": " + db.name_from_id(current_species_id)
  current_species_id = db.parent_id_from_id(current_species_id)
end

filter_array = [
  "Bacteria",
  "Archaea",
  "Viridiplantae",
  "Rhodophyta",
  "Glaucocystophyceae",
  "Alveolata",
  "Cryptophyta",
  "stramenopiles", #<- Change
  "Amoebozoa",
  "Apusozoa",
  "Euglenozoa",
  "Fornicata",
  "Haptophyceae",
  "Heterolobosea",
  "Jakobida",
  "Katablepharidophyta",
  "Malawimonadidae",
  "Nucleariidae",
  "Oxymonadida",
  "Parabasalia",
  "Rhizaria",
  "unclassified eukaryotes",
  "Fungi",
  "Metazoa",
  "Choanoflagellida",
  "Fungi/Metazoa incertae sedis"
]

filter_hash = Hash[filter_array.collect { |taxon_name|
    [taxon_name, db.id_from_name(taxon_name)]
  }]

db.match_filter("Homo sapiens", filter_hash)