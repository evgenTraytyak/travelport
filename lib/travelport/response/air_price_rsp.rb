module Travelport::Response
  class AirPriceRsp < Base
    attr_accessor :air_segment
    attr_accessor :air_pricing_solution

    def process
      process_air_itinerary(raw_content[:air_itinerary])
      process_air_price_result(raw_content[:air_price_result])
    end

    def process_air_itinerary(content)
      self.air_segment = Travelport::Model::AirSegment.new(content[:air_segment])
    end

    def process_air_price_result(content)
      self.air_pricing_solution = Travelport::Model::PricingSolution.new(content[:air_pricing_solution])
    end
  end
end
