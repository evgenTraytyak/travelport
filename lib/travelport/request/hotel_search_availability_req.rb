module Travelport::Request
  class HotelSearchAvailabilityReq < Base

    attr_accessor :location
    attr_accessor :adults
    attr_accessor :rooms
    attr_accessor :checkin
    attr_accessor :checkout

    default_for :adults, 1
    default_for :rooms, 1
    default_for :xmlns, 'http://www.travelport.com/schema/hotel_v19_0'

    validates_presence_of :location
    validates_presence_of :adults

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => 'http://www.travelport.com/schema/common_v17_0')
          xml.HotelLocation('Location' => location)
          xml.HotelSearchModifiers('NumberOfAdults' => adults, 'NumberOfRooms' => rooms)
          xml.HotelStay {
            xml.CheckinDate checkin.strftime("%Y-%m-%d")
            xml.CheckoutDate checkout.strftime("%Y-%m-%d")
          }
        }
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Location', 'Adults', 'Rooms', 'Checkin', 'Checkout').update(:xmlns => xmlns)
    end


  end
end