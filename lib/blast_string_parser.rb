# To change this template, choose Tools | Templates
# and open the template in the editor.

class BlastStringParser
  def initialize
    
  end
  #Set up Regexps
  #SPECIES_REGEXP2 = /\A.*\[(\w* \w*).*\].*\z/ #captures the first two words in square brackets

  SPECIES_REGEXP2 = /\A.*\[(.*)\].*\z/ #captures everything in square brackets

  SGI_REGEXP = /\Agi\|(\d+)\|.*\z/
  QUERY_SEQ_REGEXP = /\A([a-zA-Z0-9]+)[_|\s].*\z/
  #do not expect whitespace after the last | for robustness, strip later
  SUBJ_ANNOTATION_REGEXP = /(?:.*\|)*(.*)\[.*/ #TODO check if this REGEXP captures the right stuff

  def get_sgi_info(a_hit_id)
    unless SGI_REGEXP.match(a_hit_id)
      raise("Wrong hit id " + a_hit_id)
    else
      return SGI_REGEXP.match(a_hit_id)[1]
    end
  end

  def get_species_name(a_hit_def)
    unless SPECIES_REGEXP2.match(a_hit_def)
      raise "No species info found!"
    else
      return SPECIES_REGEXP2.match(a_hit_def)[1]
    end
  end

  def get_subject_annotation(a_hit_def)
    unless SUBJ_ANNOTATION_REGEXP.match(a_hit_def)
      puts "Can not parse subject annotation " + a_hit_def + "\n"
      return a_hit_def
    else
      return SUBJ_ANNOTATION_REGEXP.match(a_hit_def)[1].strip
    end
  end

  def get_query_seq(a_query)
    unless QUERY_SEQ_REGEXP.match(a_query)
      return a_query
    else
      return QUERY_SEQ_REGEXP.match(a_query)[1]
    end
  end
end
