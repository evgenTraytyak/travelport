module Travelport::Response
  class HotelSearchAvailabilityRsp < Base

    # Returns an array of HotelProperty search results
    def hotel_search_results
      @hotel_search_results ||= if results = raw_content[:hotel_search_result]
        results.map do |hotel_search_result|
          Travelport::Model::HotelProperty.new(hotel_search_result[:hotel_property].merge(:search_error => hotel_search_result[:hotel_search_error]))
        end
      else
        []
      end
    end

  end
end