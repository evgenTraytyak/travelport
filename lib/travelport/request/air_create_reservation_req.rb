module Travelport::Request
  class AirCreateReservationReq < Base
    attr_accessor :price
    attr_accessor :travelers

    attr_accessor :xmlns_air

    default_for :xmlns, 'http://www.travelport.com/schema/universal_v38_0'
    default_for :xmlns_air, 'http://www.travelport.com/schema/air_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
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
            end
          end
          air_price_rsp = price[:air_price_rsp]
          air_price_result = air_price_rsp[:air_price_result]
          air_itinerary =  air_price_rsp[:air_itinerary]
          air_pricing_solution = air_price_result[:air_pricing_solution]
          air_segments = [air_itinerary[:air_segment]].flatten
          air_pricing_infos = [air_pricing_solution[:air_pricing_info]].flatten
          xml.AirPricingSolution('xmlns' => xmlns_air, 'Key' => air_pricing_solution[:@key]) do
            air_segments.each do |segment|
              xml.AirSegment('Key' => segment[:@key],
                             'FlightNumber' => segment[:@flight_number],
                             'Group' => segment[:@group],
                             'ChangeOfPlane' => segment[:@change_of_plane],
                             'ProviderCode' => segment[:@provider_code],
                             'Equipment' => segment[:@equipment],
                             'OptionalServicesIndicator' => segment[:@optional_services_indicator],
                             'ClassOfService' => 'E',
                             'Carrier' => segment[:@carrier],
                             'Origin' => segment[:@origin],
                             'DepartureTime' => segment[:@departure_time],
                             'ArrivalTime' => segment[:@arrival_time],
                             'Destination' => segment[:@destination])
              air_pricing_infos.each do |air_pricing_info|
                fare_infos = [air_pricing_info[:fare_info]].flatten
                booking_infos = [air_pricing_info[:booking_info]].flatten
                taxes = [air_pricing_info[:tax_info]].flatten

                xml.AirPricingInfo('Key' => air_pricing_info[:@key],
                                   'PricingMethod' => air_pricing_info[:@pricing_method]) do

                  fare_infos.each do |fare_info|
                    fare_rule_key = fare_info[:fare_rule_key]
                    xml.FareInfo('Key' => fare_info[:@key],
                                 'EffectiveDate' => fare_info[:@effective_date],
                                 'FareBasis' => fare_info[:@fare_basis],
                                 'PassengerTypeCode' => fare_info[:@passenger_type_code],
                                 'Origin' => fare_info[:@origin],
                                 'Destination' => fare_info[:@destination]) do
                      xml.FareRuleKey(fare_rule_key, 'FareInfoRef' => fare_info[:@key],
                                                     'ProviderCode' => segment[:@provider_code])
                    end
                  end
                  booking_infos.each do |booking_info|
                    xml.BookingInfo('BookingCode' => booking_info[:@booking_code],
                                    'FareInfoRef' => booking_info[:@fare_info_ref])
                  end
                  taxes.each do |tax|
                    xml.TaxInfo('Category' => tax[:@category], 'Amount' => tax[:@amount])
                  end
                  xml.FareCalc(air_pricing_info[:fare_calc])
                  travelers.each_with_index do |traveler, idx|
                    xml.PassengerType('BookingTravelerRef' => idx, 'Code' => traveler['type'])
                  end
                end
              end
            end
          end
          xml.ActionStatus('ProviderCode' => '1P', 'Type' => 'TAW', 'TicketDate' => DateTime.now.strftime('%Y-%m-%dT%H:%M:00.000'), 'xmlns' => xmlns_common)
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'XmlnsAir', 'Price', 'Travelers').update(xmlns: xmlns)
    end
  end
end
