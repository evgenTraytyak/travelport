module Travelport::Response
  class VehicleSearchAvailabilityRsp < Base
    def vehicle
      vehicle = raw_content[:vehicle]
      array = vehicle.is_a?(Array) ? vehicle : [vehicle]
      @vehicle ||= array.map do |value|
        Travelport::Model::Vehicle.new(value)
      end
    end

    def vehicle_date_location
      @vehicle_date_location ||=
        Travelport::Model::VehicleDateLocation
        .new(raw_content[:vehicle_date_location])
    end
  end
end
