module Travelport::Request
  class VehicleMediaLinksReq < Base
    attr_accessor :location
    attr_accessor :vendor_code
    attr_accessor :air_conditioning
    attr_accessor :category
    attr_accessor :door_count
    attr_accessor :transmission_type
    attr_accessor :vehicle_class

    default_for :xmlns, 'http://www.travelport.com/schema/vehicle_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    validates :location, presence: true

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.VehiclePickupLocation('PickUpLocation' => location) do
            xml.Vendor('Code' => vendor_code)
            xml.VehicleModifier('AirConditioning' => air_conditioning,
                                'Category' => category,
                                'DoorCount' => door_count,
                                'TransmissionType' => transmission_type,
                                'VehicleClass' => vehicle_class)
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Location', 'VendorCode', 'AirConditioning',
                   'Category', 'DoorCount', 'TransmissionType',
                   'VehicleClass').update(xmlns: xmlns)
    end
  end
end
