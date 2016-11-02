module Travelport::Request
  class VehicleSearchAvailabilityReq < Base
    attr_accessor :location
    attr_accessor :pickup_date
    attr_accessor :return_date

    default_for :xmlns, 'http://www.travelport.com/schema/vehicle_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    validates :location, presence: true

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.VehicleDateLocation('PickupDateTime' => pickup_date.to_time.strftime('%Y-%m-%dT%H:%M:00'),
                                  'PickupLocation' => location,
                                  'ReturnDateTime' => return_date.to_time.strftime('%Y-%m-%dT%H:%M:00'))
          xml.VehicleSearchModifiers('SellableRatesOnly' => true) do
            xml.SearchDistance('Direction' => 'NE',
                               'MaxDistance' => 15,
                               'MinDistance' => 1,
                               'Units' => 'KM')
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Location', 'PickupDate', 'ReturnDate').update(:xmlns => xmlns)
    end
  end
end
