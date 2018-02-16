class S2Netbox::Commands::BaseCommand < S2Netbox::ApiRequest
  include S2Netbox::Helpers

  def self.object_name
    raise NotImplementedError
  end

  # Actually get useful data out of a response.
  # For instance, a search for people will nest result array in
  # ApiResponse.details['PEOPLE']['PERSON']
  def self.get_data(response)
    raise NotImplementedError
  end

  def self.add(attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    send_request("Add#{object_name}", build_attributes(attributes, access_levels, user_defined_fields), session_id)
  end

  def self.find(attributes={}, access_levels=[], user_defined_fields=[], session_id=nil, limit=150)
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    response = send_request('SearchPersonData', person_attributes, session_id)
    results = get_data(response)
    # If we're under the result limit and there's a next_page, keep going
    if (!limit || results.count < limit) && response.next_key && response.next_key != '-1'
      attributes['STARTFROMKEY'] = response.next_key
      results += find(
        attributes, access_levels, user_defined_fields,
        :session_id => session_id, :limit => limit-results.count
      )
    end
    results
  end

  def self.modify(person_id, attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    person_attributes['PERSONID'] = person_id

    send_request("Modify#{object_name}", person_attributes, session_id)
  end

  def self.remove(person_id, attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    person_attributes['PERSONID'] = person_id

    send_request("Remove#{object_name}", person_attributes, session_id)
  end

  def self.build_attributes(attributes, access_levels, user_defined_fields)
    hash = map_attributes(attributes)
    hash = build_user_defined_fields(hash, user_defined_fields)
    hash = build_access_level(hash, access_levels)

    hash
  end

  def self.build_access_level(hash, access_levels)
    unless access_levels.empty?
      hash['ACCESSLEVELS'] = {:singular_node_name => 'ACCESSLEVEL', :values => Array.wrap(access_levels)}
    end

    hash
  end

  def self.build_user_defined_fields(hash, user_defined_fields)
    Array.wrap(user_defined_fields).each_with_index do |udf, index|
      hash["UDF#{index+1}"] = udf
    end

    hash
  end
end
