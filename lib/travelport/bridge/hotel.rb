module Travelport::Bridge
  class Hotel < Base

    default_for :service, 'HotelService'
    default_for :document, 'hotel_v19_0/Hotel.wsdl'

    def search_availability(location, options)
      options.assert_valid_keys(:adults, :rooms, :checkin, :checkout)
      req = Travelport::Request::HotelSearchAvailabilityReq.new do |obj|
        obj.location = location
        options.each {|k,v| obj.send("#{k}=",v) }
      end
      Travelport::Response::HotelSearchAvailabilityRsp.new(send_request(req))
    end

    def hotel_details(chain_code, property_id, options)
      options.assert_valid_keys(:availability, :adults, :rate_rule, :rate_category, :checkin, :checkout)
      req = Travelport::Request::HotelDetailsReq.new do |obj|
        obj.chain_code = chain_code
        obj.property_id = property_id
        options.each {|k,v| obj.send("#{k}=",v) }
      end
      Travelport::Response::HotelDetailsRsp.new(send_request(req))
    end

  end
end