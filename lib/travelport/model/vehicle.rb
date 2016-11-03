class Travelport::Model::Vehicle < Travelport::Model::Base
  attr_accessor :vehicle_rate,
                :vendor_code,
                :air_conditioning,
                :transmission_type,
                :vehicle_class,
                :category,
                :door_count,
                :vendor_location_key,
                :acriss_vehicle_code
end
