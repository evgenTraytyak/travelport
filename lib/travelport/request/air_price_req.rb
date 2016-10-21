require 'pp'
module Travelport::Request
  class AirPriceReq < Base

    attr_accessor :sectors
    attr_accessor :adults
    attr_accessor :children
    attr_accessor :infants
    attr_accessor :cabin
    attr_accessor :provider_code
    attr_accessor :booking

    default_for :xmlns, 'http://www.travelport.com/schema/air_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.AirItinerary {
            booking['booking_info'].each do |leg|
              flight = leg['flight']
              xml.AirSegment('ProviderCode' => provider_code,
                             'Key' => leg['@segment_ref'],
                             'Group'=>leg['group'],
                             'ETicketability'=>leg['e_ticketability'],
                             'FlightNumber' => leg['flight_number'],
                             'Carrier' => leg['carrier'],
                             #'PlatingCarrier' => leg['plating_carrier'],
                             'FlightTime' => flight['flight_time'],
                             'DepartureTime' => leg['departure_time'].strftime("%Y-%m-%dT%H:%M:00.000"),
                             'ArrivalTime' => leg['arrival_time'].strftime("%Y-%m-%dT%H:%M:00.000"),
                             'AvailabilitySource'=>leg["availability_source"],# "AvailStatusTTY",
                             'Destination' => leg['destination'],
                             'Origin' => leg['origin']) {
                #xml.CodeshareInfo('OperatingCarrier'=>'VU','OperatingFlightNumber'=>leg['flight_number'])
                booking_code_info = leg['air_avail_info']['booking_code_info']
                xml.AirAvailInfo('ProviderCode' => provider_code) {
                  xml.BookingCodeInfo('BookingCounts' => booking_code_info['@booking_counts'])
                }

                #xml.FlightDetails('Key' => leg['key'], 'Destination' => leg['destination'], 'Origin' => leg['origin'])
              }
            end
          }
          xml.AirPricingModifiers('PlatingCarrier' => booking['plating_carrier']) if booking['plating_carrier']
          adults.times {xml.SearchPassenger('Code'=>'ADT', 'xmlns' => xmlns_common)}
          children.times {xml.SearchPassenger('Code'=>'CNN', 'Age' => 10, 'xmlns'=>xmlns_common)}
          infants.times {xml.SearchPassenger('Code'=>'INF', 'Age' => 1, 'xmlns'=>xmlns_common)}
          xml.AirPricingCommand
        }
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Sectors', 'Cabin', 'Xmlns', 'Adults', 'Children', 'Infants', 'ProviderCode', 'Booking').update(:xmlns => xmlns)
    end

  end
end
