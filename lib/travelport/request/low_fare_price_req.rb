module Travelport::Request
  class LowFarePriceReq < Base

    attr_accessor :sectors
    attr_accessor :adults
    attr_accessor :children
    attr_accessor :infants
    attr_accessor :cabin
    attr_accessor :provider_code
    attr_accessor :booking

    default_for :xmlns, 'http://www.travelport.com/schema/air_v20_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v17_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.AirItinerary {
            booking['booking_info'].each do |flight|
              xml.AirSegment('Key' => flight['@segment_ref'],
                             'Group'=>flight['group'],
                             'ETicketability'=>"Yes",
                             'FlightNumber' => flight['flight_number'],
                             'Carrier' => flight['carrier'],
                             'DepartureTime' => flight['departure_time'],
                             'ArrivalTime' => flight['arrival_time'],
                             'AvailabilitySource'=>"AvailStatusTTY",
                             'Destination' => flight['destination'],
                             'Origin' => flight['origin']) {
                xml.AirAvailInfo('ProviderCode' => provider_code) {
                  xml.BookingCodeInfo('BookingCounts' => "AC|Y9|B9|H9|K9|M9|V9|N9|X9|L9|SC|RC|WC|ZC|TC")
                }
                xml.FlightDetails('Key' => flight['key'], 'Destination' => flight['destination'], 'Origin' => flight['origin'])
              }
            end
          }
          xml.AirPricingModifiers
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