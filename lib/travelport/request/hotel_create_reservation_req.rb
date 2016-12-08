module Travelport::Request
  class HotelCreateReservationReq < Base
    attr_accessor :hotel
    attr_accessor :travelers
    attr_accessor :checkin
    attr_accessor :checkout
    attr_accessor :adults
    attr_accessor :rooms
    attr_accessor :rate_plan_type

    attr_accessor :xmlns_hotel

    default_for :xmlns, 'http://www.travelport.com/schema/universal_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'
    default_for :xmlns_hotel, 'http://www.travelport.com/schema/hotel_v38_0'

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

          # xml.FormOfPayment('xmlns' => xmlns_common, 'Key' => 'jwt2mcK1Qp27I2xfpcCtAw==', 'Type' => 'Credit') do
          #   xml.CreditCard('CVV' => 'CVV', 'ExpDate' => '2016-12', 'Key' => 'GAJOYrVu4hGShsrlYIhwmw==',
          #                  'Name' => 'TEST', 'Number' => '4123456789001111', 'Type' => 'MC') do
          #     xml.BillingAddress do
          #       xml.AddressName 'Charlotte'
          #       xml.Street '10 Charlie Street'
          #       xml.City 'Perth'
          #       xml.State 'WA'
          #       xml.PostalCode '6000'
          #       xml.Country 'AU'
          #     end
          #   end
          # end

          xml.HotelRateDetail('xmlns' => xmlns_hotel, 'RatePlanType' => rate_plan_type)

          xml.HotelProperty('xmlns' => xmlns_hotel, 'HotelChain' => hotel.hotel_property[:hotel_chain], 'HotelCode' => hotel.hotel_property[:hotel_code])

          xml.HotelStay('xmlns' => xmlns_hotel) do
            xml.CheckinDate checkin.strftime('%Y-%m-%d')
            xml.CheckoutDate checkout.strftime('%Y-%m-%d')
          end

          xml.Guarantee('xmlns' => xmlns_common, 'Type' => 'Guarantee') do
            xml.CreditCard('BankCountryCode' => 'US', 'BankName' => 'USB',
                           'ExpDate' => '2016-12', 'Type' => 'VI',
                           'Number' => '4012888888881881')
          end

          xml.GuestInformation('xmlns' => xmlns_hotel, 'NumberOfRooms' => rooms) do
            xml.NumberOfAdults adults
          end

          xml.ActionStatus('Type' => 'ACTIVE', 'xmlns' => xmlns_common)
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'XmlnsHotel', 'Rooms', 'Hotel', 'Adults', 'Checkin', 'Checkout', 'Travelers', 'RatePlanType').update(xmlns: xmlns)
    end
  end
end
