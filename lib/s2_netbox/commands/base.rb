class S2Netbox::Commands::BaseCommand < S2Netbox::ApiRequest
  include S2Netbox::Helpers

  def self.object_name
    raise NotImplementedError
  end

  def self.add(attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    send_request("Add#{object_name}", build_attributes(attributes, access_levels, user_defined_fields), session_id)
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

  def self.paginate(command, request_attributes, response: nil, session_id: nil)
    pages = 0
    response = response ? response : send_request(command, request_attributes, session_id)
    next_key = response.next_key
    while next_key && next_key != '-1'
      next_attributes = Marshal.load(Marshal.dump(request_attributes))
      next_attributes['STARTFROMKEY'] = next_key
      next_response = send_request(command, next_attributes, session_id)
      response.add_page(next_response)
      next_key = next_response.next_key
    end
    response
  end
end
