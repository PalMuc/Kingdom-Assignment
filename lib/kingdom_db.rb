require 'sequel'

class KingdomDB

  ROOT_ID = "1"
  SCIENTIFIC_NAME = "scientific name"

  def initialize(server, user, password, database)
    
    connect_string = 'mysql://'+ server + '/' + database + '?user=' + user

    if !password.nil?
      connect_string = connect_string + '&password=' + password
    end

    if !defined?(RUBY_ENGINE)
      #This is most likey 1.8.7
    else
      if RUBY_ENGINE == 'jruby'
        #This is JRuby, using jdbc
        connect_string = 'jdbc:' + connect_string
      end
    end
    
    @database = Sequel.connect(connect_string)
    
  end
  
  def id_from_name(taxon_name)
    #TODO should this only capture scientific names?

    db_results = @database[:names].filter(:name => taxon_name, :class => SCIENTIFIC_NAME).map(:taxonid)
    
    if db_results.size == 0
      raise("No results for taxon name " + taxon_name.to_s)
    elsif db_results.size > 1
      raise("Results not unique for taxon name " + taxon_name.to_s + ": " + db_results.inspect)
    else
      return db_results[0].to_s
    end
  end

  def name_from_id(taxon_id)
    db_results = @database[:names].filter(:taxonid => taxon_id.to_s, :class => SCIENTIFIC_NAME).map(:name)

    if db_results.size == 0
      raise("No results for taxon id " + taxon_id.to_s)
    elsif db_results.size > 1
      raise("Results not unique: " + db_results.inspect)
    else
      return db_results[0]
    end
  end

  def parent_id_from_id(taxon_id)
    db_results = @database[:nodes].filter(:taxonid => taxon_id.to_s).map(:parenttaxonid)

    if db_results.size == 0
      raise("No results for taxon id " + taxon_id.to_s)
    elsif db_results.size > 1
      raise("Results not unique: " + db_results.inspect)
    else
      return db_results[0].to_s
    end
    
  end

  def node_rank_from_id(taxon_id)
    db_results = @database[:nodes].filter(:taxonid => taxon_id.to_s).map(:rank)


    if db_results.size == 0
      raise("No results for taxon id " + taxon_id.to_s)  
    elsif db_results.size > 1
      raise("Results not unique: " + db_results.inspect)
    else
      return db_results[0].to_s
    end
    
  end

  def get_filter(name_array)
    filter_hash = Hash[name_array.collect { |taxon_name|
                         [taxon_name, id_from_name(taxon_name)]
                       }]
    return filter_hash
  end

  def match_filter(taxon_name, filter_hash)
    
    current_species_id = id_from_name(taxon_name)
    
    while ((current_species_id.to_i > ROOT_ID.to_i)&&(!filter_hash.has_value?(current_species_id)))
      current_species_id = parent_id_from_id(current_species_id)
    end
    if current_species_id == ROOT_ID
      return nil
    else
      return name_from_id(current_species_id)
    end
  end
end
