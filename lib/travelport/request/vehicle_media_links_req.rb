module Travelport::Request
  class VehicleMediaLinksReq < Base
    attr_accessor :location
    attr_accessor :vehicle

    default_for :xmlns, 'http://www.travelport.com/schema/vehicle_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    validates :location, presence: true

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.VehiclePickupLocation('PickUpLocation' => location) do
            xml.Vendor('Code' => vehicle[:@vendor_code])
            xml.VehicleModifier('AirConditioning' => vehicle[:@air_conditioning],
                                'Category' => vehicle[:@category],
                                'DoorCount' => vehicle[:@door_count],
                                'TransmissionType' => vehicle[:@transmission_type],
                                'VehicleClass' => vehicle[:@vehicle_class])
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Location', 'Vehicle').update(:xmlns => xmlns)
    end
  end
end
