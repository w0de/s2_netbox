require_relative 'base'

class S2Netbox::Commands::Person < S2Netbox::Commands::BaseCommand
  def self.object_name
    'Person'
  end

  def self.get_data(response)
    response.details['PEOPLE']['PERSON']
  end

  def self.get(person_id, attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    person_attributes['PERSONID'] = person_id

    send_request("Get#{object_name}", person_attributes, session_id)
  end

  def self.all(session_id=nil)
    find(:session_id => session_id)
  end

end
