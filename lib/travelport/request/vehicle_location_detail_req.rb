module Travelport::Request
  class VehicleLocationDetailReq < Base
    attr_accessor :location
    attr_accessor :pickup_date
    attr_accessor :return_date
    attr_accessor :vendor_code
    attr_accessor :vendor_location_id
    attr_accessor :provider_code

    default_for :xmlns, 'http://www.travelport.com/schema/vehicle_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    validates :location, presence: true

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.Vendor('Code' => vendor_code)
          xml.VehicleDateLocation('PickupLocation' => location,
                                  'PickupDateTime' => pickup_date.to_time.strftime('%Y-%m-%dT%H:%M:00'),
                                  'ReturnDateTime' => return_date.to_time.strftime('%Y-%m-%dT%H:%M:00'),
                                  'ReturnLocation' => location) do
            xml.VendorLocation('ProviderCode' => provider_code,
                               'VendorCode' => vendor_code,
                               'VendorLocationID' => vendor_location_id)
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Location', 'PickupDate', 'ReturnDate', 'VendorCode', 'VendorLocationId', 'ProviderCode').update(:xmlns => xmlns)
    end
  end
end
