module Travelport::Response
  class VehicleLocationDetailRsp < Base
    def vehicle_location_detail
      @vehicle ||= Travelport::Model::VehicleLocationDetail.new(raw_content)
    end
  end
end
