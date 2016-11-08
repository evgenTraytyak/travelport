module Travelport::Request
  class AirCreateReservationReq < Base
    attr_accessor :price
    attr_accessor :travelers

    attr_accessor :retain_reservation
    attr_accessor :xmlns_air

    default_for :retain_reservation, 'Both'
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
          air_pricing_solution = price.air_pricing_solution
          air_segment = price.air_segment
          air_pricing_info = air_pricing_solution.air_pricing_info
          xml.AirPricingSolution('xmlns' => xmlns_air, 'Key' => air_pricing_solution.key,
                                 'TotalPrice' => air_pricing_info[:total_price],
                                 'BasePrice' => air_pricing_info[:base_price],
                                 'ApproximateTotalPrice' => air_pricing_info[:approximate_total_price],
                                 'ApproximateBasePrice' => air_pricing_info[:approximate_base_price],
                                 'EquivalentBasePrice' => air_pricing_info[:equivalent_base_price],
                                 'ApproximateTaxes' => air_pricing_info[:approximate_taxes],
                                 'Taxes' => air_pricing_info[:taxes]) do
            xml.AirSegment('Key' => air_segment.key,
                           'FlightNumber' => air_segment.flight_number,
                           'Group' => air_segment.group,
                           'ChangeOfPlane' => air_segment.change_of_plane,
                           'ProviderCode' => air_segment.provider_code,
                           'Equipment' => air_segment.equipment,
                           'OptionalServicesIndicator' => air_segment.optional_services_indicator,
                           'ClassOfService' => 'E',
                           'Carrier' => air_segment.carrier,
                           'Origin' => air_segment.origin,
                           'DepartureTime' => air_segment.departure_time,
                           'ArrivalTime' => air_segment.arrival_time,
                           'Destination' => air_segment.destination)

            fare_infos = [air_pricing_info[:fare_info]].flatten
            booking_infos = [air_pricing_info[:booking_info]].flatten
            taxes = [air_pricing_info[:tax_info]].flatten

            xml.AirPricingInfo('Key' => air_pricing_info[:key],
                               'PricingMethod' => air_pricing_info[:pricing_method],
                               'TotalPrice' => air_pricing_info[:total_price],
                               'BasePrice' => air_pricing_info[:base_price],
                               'ApproximateTotalPrice' => air_pricing_info[:approximate_total_price],
                               'ApproximateBasePrice' => air_pricing_info[:approximate_base_price],
                               'EquivalentBasePrice' => air_pricing_info[:equivalent_base_price],
                               'ApproximateTaxes' => air_pricing_info[:approximate_taxes],
                               'Taxes' => air_pricing_info[:taxes],
                               'LatestTicketingTime' => air_pricing_info[:latest_ticketing_time],
                               'PlatingCarrier' => air_pricing_info[:plating_carrier],
                               'ProviderCode' => air_pricing_info[:provider_code]) do

              fare_infos.each do |fare_info|
                fare_rule_key = fare_info[:fare_rule_key]
                xml.FareInfo('Key' => fare_info[:key],
                             'EffectiveDate' => fare_info[:effective_date],
                             'FareBasis' => fare_info[:fare_basis],
                             'PassengerTypeCode' => fare_info[:passenger_type_code],
                             'Origin' => fare_info[:origin],
                             'Destination' => fare_info[:destination],
                             'Amount' => fare_info[:amount],
                             'TaxAmount' => fare_info[:tax_amount]) do
                  xml.FareRuleKey(fare_rule_key, 'FareInfoRef' => fare_info[:key],
                                                 'ProviderCode' => air_segment.provider_code)
                end
              end
              booking_infos.each do |booking_info|
                @host_token_ref = booking_info[:host_token_ref]
                xml.BookingInfo('BookingCode' => booking_info[:booking_code],
                                'FareInfoRef' => booking_info[:fare_info_ref],
                                'SegmentRef' => booking_info[:segment_ref],
                                'HostTokenRef' => booking_info[:host_token_ref])
              end
              taxes.each do |tax|
                xml.TaxInfo('Category' => tax[:category], 'Amount' => tax[:amount])
              end
              xml.FareCalc(air_pricing_info[:fare_calc])
              travelers.each_with_index do |traveler, idx|
                xml.PassengerType('BookingTravelerRef' => idx, 'Code' => traveler['type'])
              end

              baggage_allowances = air_pricing_info[:baggage_allowances]
              baggage_allowance_info = baggage_allowances[:baggage_allowance_info]
              carry_on_allowance_info = baggage_allowances[:carry_on_allowance_info]

              xml.BaggageAllowances do
                xml.BaggageAllowanceInfo('TravelerType' => baggage_allowance_info[:traveler_type],
                                         'Origin' => baggage_allowance_info[:origin],
                                         'Destination' => baggage_allowance_info[:destination],
                                         'Carrier' => baggage_allowance_info[:carrier]) do
                  xml.URLInfo do
                    xml.URL baggage_allowance_info[:url_info][:url] if baggage_allowance_info[:url_info]
                  end
                  xml.TextInfo do
                    baggage_allowance_info[:text_info][:text].each do |text|
                      xml.Text text
                    end
                  end
                  baggage_allowance_info[:bag_details].each do |bag_detail|
                    xml.BagDetails('ApplicableBags' => bag_detail[:applicable_bags],
                                   'BasePrice' => bag_detail[:base_price],
                                   'ApproximateBasePrice' => bag_detail[:approximate_base_price],
                                   'TotalPrice' => bag_detail[:total_price],
                                   'ApproximateTotalPrice' => bag_detail[:approximate_total_price]) do
                      xml.BaggageRestriction do
                        xml.TextInfo do
                          xml.Text bag_detail[:baggage_restriction][:text_info][:text]
                        end
                      end
                    end
                  end
                end

                xml.CarryOnAllowanceInfo('Origin' => carry_on_allowance_info[:origin],
                                         'Destination' => carry_on_allowance_info[:destination],
                                         'Carrier' => carry_on_allowance_info[:carrier]) do
                  xml.URLInfo do
                    xml.URL carry_on_allowance_info[:url_info][:url] if carry_on_allowance_info[:url_info]
                  end
                  xml.TextInfo do
                    if carry_on_allowance_info[:text_info][:text].is_a? Array
                      carry_on_allowance_info[:text_info][:text].each do |text|
                        xml.Text text
                      end
                    else
                      xml.Text carry_on_allowance_info[:text_info][:text]
                    end
                  end
                  carry_on_allowance_info[:carry_on_details].each do |carry_on_detail|
                    xml.CarryOnDetails('ApplicableCarryOnBags' => carry_on_detail[:applicable_bags],
                                       'BasePrice' => carry_on_detail[:base_price],
                                       'ApproximateBasePrice' => carry_on_detail[:approximate_base_price],
                                       'TotalPrice' => carry_on_detail[:total_price],
                                       'ApproximateTotalPrice' => carry_on_detail[:approximate_total_price]) do
                      xml.BaggageRestriction do
                        xml.TextInfo do
                          xml.Text carry_on_detail[:baggage_restriction][:text_info][:text]
                        end
                      end
                    end
                  end
                end
              end
            end
            xml.HostToken(air_pricing_solution.host_token, 'xmlns' => xmlns_common, 'Key' => @host_token_ref)
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
