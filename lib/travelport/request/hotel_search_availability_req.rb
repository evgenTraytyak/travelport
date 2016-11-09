module Travelport::Request
  class HotelSearchAvailabilityReq < Base

    attr_accessor :location
    attr_accessor :coordinates
    attr_accessor :adults
    attr_accessor :children
    attr_accessor :rooms
    attr_accessor :checkin
    attr_accessor :checkout
    attr_accessor :available_only
    attr_accessor :provider_code

    default_for :adults, 1
    default_for :children, 0
    default_for :rooms, 1
    default_for :available_only, true
    default_for :provider_code, '1P'
    default_for :xmlns, 'http://www.travelport.com/schema/hotel_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    validates :location, presence: true, if: "coordinates.blank?"
    validates :coordinates, presence: true, if: "location.blank?"
    validates_presence_of :adults

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.HotelSearchLocation do
            xml.HotelLocation('Location' => location) if location
            xml.CoordinateLocation('latitude' => coordinates[:latitude],
                                   'longitude' => coordinates[:longitude],
                                   'xmlns' => xmlns_common) if coordinates
          end
          xml.HotelSearchModifiers('NumberOfAdults' => adults, 'NumberOfRooms' => rooms, 'AvailableHotelsOnly' => available_only) do
            xml.PermittedProviders('xmlns' => xmlns_common) do
              xml.Provider('Code' => provider_code)
            end
            xml.NumberOfChildren('Count' => children)
            xml.BookingGuestInformation do
              xml.Room do
                xml.Adults adults
              end
            end
          end
          xml.HotelStay do
            xml.CheckinDate checkin.strftime("%Y-%m-%d")
            xml.CheckoutDate checkout.strftime("%Y-%m-%d")
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Location', 'Coordinates', 'Adults', 'Children', 'Rooms', 'Checkin', 'Checkout', 'AvailableOnly', 'ProviderCode').update(:xmlns => xmlns)
    end
  end
end
