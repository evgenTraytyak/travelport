module Travelport::Response
  class VehicleLocationDetailRsp < Base
    def vehicle_location_detail
      @vehicle_location_detail ||= Travelport::Model::VehicleLocationDetail.new(raw_content)
    end
  end
end
