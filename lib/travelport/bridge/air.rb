module Travelport::Bridge
  class Air < Base
    default_for :service, 'AirService'
    default_for :document, 'air_v38_0/Air.wsdl'

    def low_fare_search(sectors, options)
      options.assert_valid_keys(:adults, :children, :infants, :cabin, :provider_code)
      req = Travelport::Request::LowFareSearchReq.new do |obj|
        obj.sectors = sectors
        obj.adults = options[:adults]
        obj.children = options[:children]
        obj.infants = options[:infants]
        obj.cabin = options[:cabin]
        obj.provider_code = options[:provider_code]
      end
      Travelport::Response::LowFareSearchRsp.new(send_request(req))
      # send_request(req)
    end

    def price_details(air_segment_list, options)
      options.assert_valid_keys(:adults, :children, :infants, :provider_code)
      req = Travelport::Request::AirPriceReq.new do |obj|
        obj.air_segment_list = air_segment_list
        obj.adults = options[:adults]
        obj.children = options[:children]
        obj.infants = options[:infants]
        obj.provider_code = options[:provider_code]
      end
      Travelport::Response::AirPriceRsp.new(send_request(req))
    end

    def book(price, travelers)
      req = Travelport::Request::AirCreateReservationReq.new do |obj|
        obj.price = price
        obj.travelers = travelers
      end
      # Travelport::Response::AirCreateReservationRsp.new(send_request(req))
      send_request(req)
    end

    def ticket(air_reservation_locator_code, air_pricing_info_ref, card)
      req = Travelport::Request::AirTicketingReq.new do |obj|
        obj.air_reservation_locator_code = air_reservation_locator_code
        obj.air_pricing_info_ref = air_pricing_info_ref
        obj.card = card
      end
      # Travelport::Response::AirTicketingRsp.new(send_request(req))
      send_request(req)
    end
  end
end
