module Travelport::Request
  class AirCreateReservationReq < Base

    attr_accessor :price
    attr_accessor :travelers

    default_for :xmlns, 'http://www.travelport.com/schema/air_v20_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v17_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          travelers.each_with_index do |traveler,idx|
            xml.BookingTraveler('xmlns' => xmlns_common,
                                'Key'=>idx,
                                'TravelerType' => traveler['type'],
                                'Gender' => traveler['gender']) {
              xml.BookingTravelerName('First' => traveler['first_name'],
                                      'Last' => traveler['last_name'],
                                      'Prefix' => traveler['prefix'])
              xml.PhoneNumber('Number' => traveler['phone']) if traveler['phone']
              xml.Email('EmailID' => traveler['email']) if traveler['email']

            }
          end
          air_price_rsp = price['air_price_rsp']
          air_price_result = air_price_rsp['air_price_result']
          air_itinerary =  air_price_rsp['air_itinerary']
          air_pricing_solution = air_price_result['air_pricing_solution']
          air_segments = [air_itinerary['air_segment']].flatten
          air_pricing_infos = [air_pricing_solution['air_pricing_info']].flatten
          xml.AirPricingSolution('xmlns' => xmlns, 'Key' => air_pricing_solution['@key']) {
            air_segments.each do |segment|
              flight = segment['flight_details']

              xml.AirSegment('Key' => segment['@key'],
                             'FlightNumber' => segment['@flight_number'],
                             'Group' => segment['@group'],
                             'ClassOfService' => segment['@class_of_service'],
                             'ETicketability' => segment['@e_ticketability'],
                             'AvailabilitySource' => segment['@availability_source'],
                             'Carrier' => segment['@carrier'],
                             'Origin' => segment['@origin'],
                             'DepartureTime' => DateTime.parse(segment['@departure_time'].to_s[0,19]).strftime("%Y-%m-%dT%H:%M:00.000"),
                             'ArrivalTime' => DateTime.parse(segment['@arrival_time'].to_s[0,19]).strftime("%Y-%m-%dT%H:%M:00.000"),
                             'Destination' => segment['@destination']) {
                xml.FlightDetails('Key' => flight['@key'],
                                  'Origin' => flight['@origin'],
                                  'Destination' => flight['@destination'])

              }
              air_pricing_infos.each do |air_pricing_info|

                fare_infos = [air_pricing_info['fare_info']].flatten
                booking_infos = [air_pricing_info['booking_info']].flatten
                taxes = [air_pricing_info['tax_info']].flatten

                xml.AirPricingInfo('Key' => air_pricing_info["@key"],
                                   'PricingMethod' => air_pricing_info['@pricing_method']) {

                  fare_infos.each do |fare_info|
                    fare_rule_key = fare_info['fare_rule_key']
                    xml.FareInfo('Key' => fare_info["@key"],
                                 'EffectiveDate' => fare_info['@effective_date'],
                                 'FareBasis' => fare_info['@fare_basis'],
                                 'PassengerTypeCode' => fare_info['@passenger_type_code'],
                                 'Origin' => fare_info['@origin'],
                                 'Destination' => fare_info['@destination']) {
                      xml.FareRuleKey(fare_rule_key, 'FareInfoRef' => fare_info["@key"] ,
                                      'ProviderCode' => segment['@provider_code'] )

                    }
                  end
                  booking_infos.each do |booking_info|
                    xml.BookingInfo('BookingCode' => booking_info['@booking_code'],
                                    'FareInfoRef' => booking_info['@fare_info_ref'])
                  end
                  taxes.each do |tax|
                    xml.TaxInfo('Category' => tax['@category'], 'Amount' => tax['@amount'])
                  end
                  xml.FareCalc(air_pricing_info['fare_calc'])
                  travelers.each_with_index do |traveler,idx|
                    xml.PassengerType('BookingTravelerRef'=>idx,'Code'=>traveler['type'])
                  end
                }
              end
            end
          }
          xml.ActionStatus('Type'=>"ACTIVE", 'xmlns'=>xmlns_common)
        }
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns','Price','Travelers').update(:xmlns => xmlns)
    end

  end
end