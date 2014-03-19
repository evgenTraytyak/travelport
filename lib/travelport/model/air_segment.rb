module Travelport::Model
  class AirSegment < Base

    attr_accessor :air_avail_info,
                  :flight_details_ref,
                  :key,
                  :group,
                  :carrier,
                  :flight_number,
                  :origin,
                  :destination,
                  :departure_time,
                  :arrival_time,
                  :flight_time,
                  :travel_time,
                  :distance,
                  :class_of_service,
                  :e_ticketability,
                  :equipment,
                  :change_of_plane,
                  :participant_level,
                  :link_availability,
                  :polled_availability_option,
                  :optional_services_indicator,
                  :availability_source,
                  :codeshare_info

    # def departure_time=(time)
    #   @departure_time = time.to_time
    # end

    # def arrival_time=(time)
    #   @arrival_time = time.to_time
    # end

    def flight_details_ref=(ref)
      @flight_details_ref = ref[:@key]
    end

    def to_xml_attributes
      Hash[attributes.except(:air_avail_info,:flight_details_ref, :distance, :class_of_service, :codeshare_info).map do |key, value|
        [key.to_s.camelize, value]
      end]
    end
  end
end



