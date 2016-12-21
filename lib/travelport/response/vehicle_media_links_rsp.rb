module Travelport::Response
  class VehicleMediaLinksRsp < Base
    def vehicle_with_media_items
      @vehicle_with_media_items ||= Travelport::Model::VehicleWithMediaItems.new(raw_content[:vehicle_with_media_items])
    end
  end
end