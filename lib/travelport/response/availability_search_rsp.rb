module Travelport::Response
  class AvailabilitySearchRsp < Base
    attr_accessor :flight_details_list
    attr_accessor :air_segment_list
    def process
      process_raw_flight_details_list(raw_content[:flight_details_list])
      process_raw_air_segment_list(raw_content[:air_segment_list])
    end

    def process_raw_flight_details_list(list)
      self.flight_details_list = Hash[list[:flight_details].map do |flight_details|
        [flight_details[:@key], Travelport::Model::FlightDetails.new(flight_details)]
      end]
    end

    def process_raw_air_segment_list(list)
      self.air_segment_list = list[:air_segment].map do |air_segment|
         Travelport::Model::AirSegment.new(air_segment)
      end
    end

  end
end
