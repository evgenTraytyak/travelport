module Travelport::Response
  class HotelDetailsRsp < Base

    # Returns an array of rate results
    def hotel_rate_details
      @hotel_rate_details ||= if results = (raw_content[:requested_hotel_details]||{})[:hotel_rate_detail]
        results.map do |rate_result|
          Travelport::Model::HotelRate.new(rate_result)
        end
      else
        []
      end
    end

  end
end