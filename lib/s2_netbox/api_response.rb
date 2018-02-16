require 'active_support/core_ext/hash'

class S2Netbox::ApiResponse
  attr_accessor :code, :success, :details, :error_message, :raw_request, :raw_response, :session_id, :next_key

  def initialize(raw_request, raw_response)
    response_hash = Hash.from_xml(raw_response)

    @code = response_hash['NETBOX']['RESPONSE']['CODE']
    @details = response_hash['NETBOX']['RESPONSE']['DETAILS']
    @success = @code == 'SUCCESS'
    @error_message = details ? details['ERRMSG'] : nil

    @raw_request = raw_request
    @raw_response = raw_response
    @session_id = response_hash['NETBOX']['sessionid']
    @next_key = details ? details['NEXTKEY'] : nil
  end

  # Both success[ful?] are preserved for backwards compatibility
  def successful?
    success
  end
end
