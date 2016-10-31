module Travelport::Response
  class HotelMediaLinksRsp < Base
    def hotel_media_result
      @hotel_media_result ||= if results = raw_content[:hotel_property_with_media_items]
                                Travelport::Model::HotelMedia.new(results)
                              else
                                []
      end
    end
  end
end
