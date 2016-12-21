module Travelport::Request
  class VehicleCreateReservationReq < Base
    attr_accessor :vehicle_date_location
    attr_accessor :vehicle
    attr_accessor :number_of_periods
    attr_accessor :travelers
    attr_accessor :card

    attr_accessor :xmlns_vehicle

    default_for :xmlns, 'http://www.travelport.com/schema/universal_v38_0'
    default_for :xmlns_vehicle, 'http://www.travelport.com/schema/vehicle_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)

          travelers.each_with_index do |traveler, idx|
            xml.BookingTraveler('xmlns' => xmlns_common,
                                'Key' => idx,
                                'TravelerType' => traveler['traveler_type'],
                                'Gender' => traveler['gender']) do
              xml.BookingTravelerName('First' => traveler['first_name'],
                                      'Last' => traveler['last_name'],
                                      'Prefix' => traveler['prefix'])
              xml.PhoneNumber('Number' => traveler['phone']) if traveler['phone']
              xml.Email('EmailID' => traveler['email']) if traveler['email']
              xml.Address do
                xml.AddressName traveler['address_name']
                xml.Street traveler['street']
                xml.City traveler['city']
                xml.State traveler['state']
                xml.PostalCode traveler['postal_code']
                xml.Country traveler['country']
              end if traveler
            end
          end

          xml.FormOfPayment('xmlns' => xmlns_common, 'Type' => 'Credit') do
            xml.CreditCard('CVV' => card['cvv'], 'ExpDate' => card['expiration_date'],
                           'Number' => card['number'], 'Name' => card['name'], 'Type' => card['type'])
          end

          xml.VehicleDateLocation('xmlns' => xmlns_vehicle,
                                  'PickupLocation' => vehicle_date_location.pickup_location,
                                  'PickupDateTime' => vehicle_date_location.pickup_date_time.to_time.strftime('%Y-%m-%dT%H:%M:00'),
                                  'ReturnDateTime' => vehicle_date_location.return_date_time.to_time.strftime('%Y-%m-%dT%H:%M:00'),
                                  'ReturnLocation' => vehicle_date_location.return_location)
          
          xml.Vehicle('xmlns' => xmlns_vehicle,
                      'AirConditioning' => vehicle.air_conditioning,
                      'Category' => vehicle.category,
                      'DoorCount' => vehicle.door_count,
                      'TransmissionType' => vehicle.transmission_type,
                      'VehicleClass' => vehicle.vehicle_class,
                      'Location' => vehicle_date_location.vendor_location.first[:location_type],
                      'VendorCode' => vehicle.vendor_code) do
            xml.VehicleRate('NumberOfPeriods' => number_of_periods,
                            'RateCategory' => vehicle.vehicle_rate[:rate_category],
                            'RateCode' => vehicle.vehicle_rate[:rate_code],
                            'RatePeriod' => vehicle.vehicle_rate[:rate_period],
                            'UnlimitedMileage' => vehicle.vehicle_rate[:unlimited_mileage])
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Card', 'VehicleDateLocation', 'Vehicle', 'NumberOfPeriods', 'Travelers', 'XmlnsVehicle').update(:xmlns => xmlns)
    end
  end
end