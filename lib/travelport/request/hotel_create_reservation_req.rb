module Travelport::Request
  class HotelCreateReservationReq < Base
    attr_accessor :hotel
    attr_accessor :travelers
    attr_accessor :checkin
    attr_accessor :checkout
    attr_accessor :adults
    attr_accessor :rooms
    attr_accessor :credit_card

    attr_accessor :xmlns_hotel

    default_for :xmlns, 'http://www.travelport.com/schema/universal_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'
    default_for :xmlns_hotel, 'http://www.travelport.com/schema/hotel_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo(
            'OriginApplication' => billing_point_of_sale,
            'xmlns' => xmlns_common
          )
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

          xml.FormOfPayment('xmlns' => xmlns_common, 'Type' => 'Credit') do
            xml.CreditCard('CVV' => credit_card['cvv'],
                           'ExpDate' => credit_card['exp_date'],
                           'Number' => credit_card['number'],
                           'Type' => credit_card['type']) do
              # xml.BillingAddress do
              #   xml.AddressName 'Charlotte'
              #   xml.Street '10 Charlie Street'
              #   xml.City 'Perth'
              #   xml.State 'WA'
              #   xml.PostalCode '6000'
              #   xml.Country 'AU'
              # end
            end
          end

          xml.HotelRateDetail(
            'xmlns' => xmlns_hotel,
            'RatePlanType' => hotel.hotel_rate_detail.first[:rate_plan_type]
          )

          xml.HotelProperty(
            'xmlns' => xmlns_hotel,
            'HotelChain' => hotel.hotel_property[:hotel_chain],
            'HotelCode' => hotel.hotel_property[:hotel_code]
          ) do
            xml.PropertyAddress do
              hotel.hotel_property[:property_address][:address]
                   .each do |address|
                xml.Address address
              end
            end
          end

          xml.HotelStay('xmlns' => xmlns_hotel) do
            xml.CheckinDate checkin.strftime('%Y-%m-%d')
            xml.CheckoutDate checkout.strftime('%Y-%m-%d')
          end

          # exp_date format '2016-12'
          xml.Guarantee('xmlns' => xmlns_common, 'Type' => 'Guarantee') do
            xml.CreditCard('ExpDate' => credit_card['exp_date'],
                           'Type' => credit_card['type'],
                           'Number' => credit_card['number'])
          end

          xml.GuestInformation(
            'xmlns' => xmlns_hotel,
            'NumberOfRooms' => rooms
          ) do
            xml.NumberOfAdults adults
          end

          xml.ActionStatus('Type' => 'ACTIVE', 'xmlns' => xmlns_common)
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except(
        'Xmlns', 'XmlnsHotel', 'Rooms', 'Hotel',
        'Adults', 'Checkin', 'Checkout', 'Travelers',
        'CreditCard'
      ).update(xmlns: xmlns)
    end
  end
end
