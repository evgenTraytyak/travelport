module Travelport::Bridge
  class Air < Base

    default_for :service, 'AirService'
    default_for :document, 'air_v38_0/Air.wsdl'

    def low_fare_search(sectors, options)
      options.assert_valid_keys(:adults, :children, :infants, :cabin, :provider_code)
      req = Travelport::Request::LowFareSearchReq.new do |obj|
        obj.sectors = sectors
        obj.children = options[:children]
        obj.infants = options[:infants]
        obj.cabin = options[:cabin]
        obj.provider_code = options[:provider_code]
      end
      # Travelport::Response::LowFareSearchRsp.new(send_request(req))
      send_request(req)
    end

    def price_details(booking, options)
      options.assert_valid_keys(:adults, :children, :infants, :cabin, :provider_code)
      req = Travelport::Request::AirPriceReq.new do |obj|
        obj.booking = booking
        obj.adults = options[:adults]
        obj.children = options[:children]
        obj.infants = options[:infants]
        obj.provider_code = options[:provider_code]
      end
      #Travelport::Response::LowFareSearchRsp.new(send_request(req))
      send_request(req)
    end

    def book(price, travelers)
      req = Travelport::Request::AirCreateReservationReq.new do |obj|
        obj.price = price
        obj.travelers = travelers
      end
      #Travelport::Response::LowFareSearchRsp.new(send_request(req))
      #req
      send_request(req)
    end
  end
end
