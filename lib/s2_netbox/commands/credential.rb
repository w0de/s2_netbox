class S2Netbox::Commands::Credential < S2Netbox::Commands::BaseCommand
  def self.object_name
    'Credential'
  end

  def self.remove(person_id, card_format, card_id, attributes={}, access_levels=[], user_defined_fields=[], session_id=nil)
    person_attributes = build_attributes(attributes, access_levels, user_defined_fields)
    person_attributes['PERSONID'] = person_id
    person_attributes['CARDFORMAT'] = card_format
    person_attributes['CARDID'] = card_id

    send_request("Remove#{object_name}", person_attributes, session_id)
  end
end
