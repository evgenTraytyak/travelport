module Travelport::Request
  class HotelCreateReservationReq < Base
    attr_accessor :hotel
    attr_accessor :travelers
    attr_accessor :checkin
    attr_accessor :checkout
    attr_accessor :adults

    default_for :xmlns, 'http://www.travelport.com/schema/hotel_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale,
                                     'xmlns' => xmlns_common)
          travelers.each_with_index do |traveler, idx|
            xml.BookingTraveler('xmlns' => xmlns_common,
                                'Key' => idx,
                                'TravelerType' => traveler['type'],
                                'Gender' => traveler['gender']) do
              xml.BookingTravelerName('First' => traveler['first_name'],
                                      'Last' => traveler['last_name'],
                                      'Prefix' => traveler['prefix'])
              xml.PhoneNumber('Number' => traveler['phone']) if traveler['phone']
              xml.Email('EmailID' => traveler['email']) if traveler['email']
              xml.Address do
                xml.AddressName traveler['address']['address_name']
                xml.Street traveler['address']['street']
                xml.City traveler['address']['city']
                xml.State traveler['address']['state']
                xml.PostalCode traveler['address']['postal_code']
                xml.Country traveler['address']['country']
              end if traveler['address']
            end
          end

          xml.HotelProperty('xmlns' => xmlns) do
            xml.PropertyAddress do
              hotel.hotel_property[:property_address][:address].each do |address|
                xml.Address address
              end
            end
          end

          xml.HotelStay('xmlns' => xmlns) do
            xml.CheckinDate checkin.strftime('%Y-%m-%d')
            xml.CheckoutDate checkout.strftime('%Y-%m-%d')
          end

          # xml.Guarantee('xmlns' => xmlns_common) do
          # end

          xml.GuestInformation('xmlns' => xmlns) do
            xml.NumberOfAdults adults
          end

          xml.ActionStatus('Type' => 'ACTIVE', 'xmlns' => xmlns_common)
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Hotel', 'Adults', 'Checkin', 'Checkout', 'Travelers').update(xmlns: 'http://www.travelport.com/schema/universal_v38_0')
    end
  end
end
