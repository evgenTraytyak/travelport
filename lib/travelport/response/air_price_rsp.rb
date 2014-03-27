module Travelport::Response
  class AirPriceRsp < Base
    attr_accessor :air_price_result
    def process
      process_raw_air_price_result(raw_content[:air_price_result])
    end

    def process_raw_air_price_result(list)
      if list.kind_of?(Array)
         self.air_price_result = list.map do |price_solution|
          air_price_solution(price_solution)
        end
      else
        self.air_price_result = []
        self.air_price_result << air_price_solution(list)
      end

    end

    protected

    def air_price_solution(price_solution)
      Travelport::Model::AirPriceSolution.new(price_solution[:air_pricing_solution])
    end
  end
end
