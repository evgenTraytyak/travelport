module Travelport::Bridge
  class Air < Base

    default_for :service, 'AirService'
    default_for :document, 'air_v25_0/Air.wsdl'

    def low_fare_search(sectors, options)
      options.assert_valid_keys(:adults, :children, :infants, :cabin)
      req = Travelport::Request::LowFareSearchReq.new do |obj|
        obj.sectors = sectors
        obj.children = options[:children]
        obj.infants = options[:infants]
        obj.cabin = options[:cabin]
      end
      Travelport::Response::LowFareSearchRsp.new(send_request(req))
    end

    def air_price_req(segment, options = {})
      options.assert_valid_keys(:adults, :children, :infants, :cabin, :airline_code)
      req = Travelport::Request::AirPriceReq.new do |obj|
        obj.segment = segment
        obj.children = options[:children]
        obj.infants = options[:infants]
        obj.cabin = options[:cabin]
        obj.adults = options[:adults]
      end
      send_request req
      #Travelport::Response::AirPriceRsp.new(send_request(req))
    end

    def availability_search_req(sector, options)
      options.assert_valid_keys(:adults, :children, :infants, :cabin)
      req = Travelport::Request::AvailabilitySearchReq.new do |obj|
        obj.sector = sector
        obj.children = options[:children]
        obj.infants = options[:infants]
        obj.cabin = options[:cabin]
        obj.adults = options[:adults]
      end
      Travelport::Response::AvailabilitySearchRsp.new(send_request(req))
    end
  end
end
