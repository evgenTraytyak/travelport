class Travelport::Model::VehicleDateLocation < Travelport::Model::Base
  attr_accessor :vendor_location,
                :pickup_date_time,
                :pickup_location,
                :return_date_time,
                :return_location
end
