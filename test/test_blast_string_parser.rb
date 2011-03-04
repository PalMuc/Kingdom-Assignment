require 'helper'
require 'blast_string_parser'

class BlastStringParserTest < Test::Unit::TestCase
  def test_get_species_info
    bsp = BlastStringParser.new()
    assert_equal "Xenopus (Silurana) tropicalis", bsp.get_species_name("PREDICTED: uncharacterized protein K02A2.6-like [Xenopus (Silurana) tropicalis]")
    assert_equal "Corticium_candelabrum", bsp.get_species_name("CC1c114_molpal [Corticium_candelabrum]")
  end
  def test_get_query_seq
    bsp = BlastStringParser.new()
    assert_equal "Aqu1.200003", bsp.get_query_seq("Aqu1.200003")
    assert_equal "AW3C1", bsp.get_query_seq("AW3C1 [Astrosclera_willeyana]")
    
  end
end
