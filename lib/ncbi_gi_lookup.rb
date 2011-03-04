require 'bio'
require 'nokogiri'

class NCBIGiLookup
  def initialize(email)
    unless email.is_a?(String)
      raise "Email address is not a String!"
    end
    @email = email
  end
  def get_species_name(gi_number)
    web_result = Bio::NCBI::REST.efetch(gi_number, {"db"=>"protein", "retmode"=>"xml", "email"=>@email})
    document = Nokogiri::XML(web_result)
    return document.xpath("//GBSeq_organism").inner_text
  end
end
