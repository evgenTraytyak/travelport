module Travelport::Bridge
  class Vehicle < Base
    default_for :service, 'VehicleService'
    default_for :document, 'vehicle_v38_0/Vehicle.wsdl'
    
    def search_availability(options)
      options.assert_valid_keys(:location, :pickup_date, :return_date)
      req = Travelport::Request::VehicleSearchAvailabilityReq.new do |obj|
        options.each { |k, v| obj.send("#{k}=", v) }
      end
      # Travelport::Response::VehicleSearchAvailabilityRsp.new(send_request(req))
      send_request(req)
    end

    def vehicle_media_links(vehicle, location)
      req = Travelport::Request::VehicleMediaLinksReq.new do |obj|
        obj.vehicle = vehicle
        obj.location = location
      end
      # Travelport::Response::VehicleMediaLinksRsp.new(send_request(req))
      send_request(req)
    end

    def vehicle_location_detail(options)
      options.assert_valid_keys(:location, :pickup_date, :return_date,
                                :vendor_code, :vendor_location_id, :provider_code)
      req = Travelport::Request::VehicleLocationDetailReq.new do |obj|
        options.each { |k, v| obj.send("#{k}=", v) }
      end
      # Travelport::Response::VehicleLocationDetailRsp.new(send_request(req))
      send_request(req)
    end

    def book_vehicle(vehicle, vehicle_date_location, number_of_periods, travelers)
      req = Travelport::Request::VehicleCreateReservationReq.new do |obj|
        obj.vehicle = vehicle
        obj.vehicle_date_location = vehicle_date_location
        obj.number_of_periods = number_of_periods
        obj.travelers = travelers
      end
      #Travelport::Response::VehicleCreateReservationRsp.new(send_request(req))
      send_request(req)
    end
  end
end
