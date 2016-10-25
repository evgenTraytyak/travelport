module Travelport::Response
  class HotelDetailsRsp < Base
    # Returns an array of rate results
    def hotel_rate_details
      @hotel_rate_details ||= if results = raw_content[:requested_hotel_details]
                                Travelport::Model::HotelRate.new(results)
                              else
                                []
      end
    end
  end
end
