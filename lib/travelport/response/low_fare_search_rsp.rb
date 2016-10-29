module Travelport::Response
  class LowFareSearchRsp < Base
    attr_accessor :flight_details_list
    attr_accessor :air_segment_list
    attr_accessor :fare_info_list
    # attr_accessor :route_list
    attr_accessor :air_price_point_list

    def process
      process_raw_flight_details_list(raw_content[:flight_details_list])
      process_raw_air_segment_list(raw_content[:air_segment_list])
      process_raw_fare_info_list(raw_content[:fare_info_list])
      process_raw_route_list(raw_content[:route_list])
      process_raw_air_pricing_solution(raw_content[:air_price_point_list])
    end

    def process_raw_flight_details_list(list)
      array = list[:flight_details].is_a?(Array) ? list[:flight_details] : [list[:flight_details]]
      self.flight_details_list = Hash[array.map do |flight_details|
        [flight_details[:@key], Travelport::Model::FlightDetails.new(flight_details)]
      end]
    end

    def process_raw_air_segment_list(list)
      array = list[:air_segment].is_a?(Array) ? list[:air_segment] : [list[:air_segment]]
      self.air_segment_list = Hash[array.map do |air_segment|
        [air_segment[:@key], Travelport::Model::AirSegment.new(air_segment)]
      end]
    end

    def process_raw_fare_info_list(list)
      array = list[:fare_info].is_a?(Array) ? list[:fare_info] : [list[:fare_info]]
      self.fare_info_list = Hash[array.map do |fare_info|
        [fare_info[:@key], Travelport::Model::FareInfo.new(fare_info)]
      end]
    end

    def process_raw_route_list(list)
    end

    def process_raw_air_pricing_solution(list)
      array = list[:air_price_point].is_a?(Array) ? list[:air_price_point] : [list[:air_price_point]]
      self.air_price_point_list = Hash[array.map do |air_price_point|
        [air_price_point[:@key], Travelport::Model::PricingSolution.new(air_price_point)]
      end]
    end
  end
end
