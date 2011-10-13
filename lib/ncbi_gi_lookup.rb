require 'bio'
require 'nokogiri'

#TODO Port this to using the MySQL db
#TODO Get rid of the cache, MySQL already does caching


class NCBIGiLookup
  def initialize(email)
    unless email.is_a?(String)
      raise "Email address is not a String!"
    end
    @email = email
    #Set up a cache so we don't have to send multiple queries for the same gi number
    @cache = {}
  end
  
  def get_species_name(gi_number)
    if @cache.has_key?(gi_number)
      print "cache hit "
      return @cache[gi_number]
    else
      web_result = Bio::NCBI::REST.efetch(gi_number, {"db"=>"protein", "retmode"=>"xml", "email"=>@email})
      document = Nokogiri::XML(web_result)
      species_name = document.xpath("//GBSeq_organism").inner_text
      
      #Save species name in cache
      @cache[gi_number] = species_name
      return species_name
    end
  end
end
