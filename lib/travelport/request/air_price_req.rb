module Travelport::Request
  class AirPriceReq < Base
    attr_accessor :sectors
    attr_accessor :adults
    attr_accessor :children
    attr_accessor :infants
    attr_accessor :provider_code
    attr_accessor :air_segment_list

    default_for :xmlns, 'http://www.travelport.com/schema/air_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.AirItinerary do
            air_segment_list.each do |value|
              xml.AirSegment('ProviderCode' => provider_code,
                             'Key' => value[:key],
                             'OptionalServicesIndicator' => value[:optional_services_indicator],
                             'Group' => value[:group],
                             'Equipment' => value[:equipment],
                             'ETicketability' => value[:e_ticketability],
                             'FlightNumber' => value[:flight_number],
                             'Carrier' => value[:carrier],
                             'ChangeOfPlane' => value[:change_of_plane],
                             'FlightTime' => value[:flight_time],
                             'DepartureTime' => value[:departure_time],
                             'ArrivalTime' => value[:arrival_time],
                             'Destination' => value[:destination],
                             'Distance' => value[:distance],
                             'Origin' => value[:origin])
            end
          end
          adults.times { xml.SearchPassenger(
              'Code' => 'ADT',
              'BookingTravelerRef' => 'gr8AVWGCR064r57Jt0+8bA==',
              'xmlns' => xmlns_common
          )} if adults.present?
          children.times { xml.SearchPassenger(
              'Code' => 'CNN',
              'BookingTravelerRef' => 'gr8AVWGCR064r57Jt0+8bA==',
              'Age' => 10,
              'xmlns' => xmlns_common
          )} if children.present?
          infants.times { xml.SearchPassenger(
              'Code' => 'INF',
              'BookingTravelerRef' => 'gr8AVWGCR064r57Jt0+8bA==',
              'Age' => 1,
              'xmlns' => xmlns_common
          )} if infants.present?
          xml.AirPricingCommand
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Sectors', 'Xmlns', 'Adults', 'Children', 'Infants', 'ProviderCode', 'AirSegmentList').update(xmlns: xmlns)
    end
  end
end
