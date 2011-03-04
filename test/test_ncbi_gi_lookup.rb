require 'helper'
require 'ncbi_gi_lookup'

class Ncbi_gi_lookup_test < Test::Unit::TestCase
  def test_initialize
    assert_raise RuntimeError do
      watson = NCBIGiLookup.new(1234)
    end
    assert_nothing_raised do
      watson = NCBIGiLookup.new("ncbi@volton.otherinbox.com")
    end
  end
  def test_get_species_name
    watson = NCBIGiLookup.new("ncbi@volton.otherinbox.com")
    assert_equal "Tribolium castaneum", watson.get_species_name("270016927")
  end
end
