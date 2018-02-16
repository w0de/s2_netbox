class S2Netbox::Commands::Person < S2Netbox::Commands::BaseCommand
  def self.object_name
    'Person'
  end

  def self.get(person_id, attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    person_attributes['PERSONID'] = person_id

    send_request("Get#{object_name}", person_attributes, session_id)
  end

  # Find does not require a person_id
  def self.find(person_id=nil, attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    if person_id
      person_attributes['PERSONID'] = person_id
    end

    send_request("SearchPersonData", person_attributes, session_id)
  end

end
