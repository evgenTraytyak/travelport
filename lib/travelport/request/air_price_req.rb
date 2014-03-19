module Travelport::Request
  class AirPriceReq < Base
    attr_accessor :segment
    attr_accessor :adults
    attr_accessor :children
    attr_accessor :infants
    attr_accessor :provider_code
    attr_accessor :cabin

    default_for :adults, 1
    default_for :infants, 1
    default_for :children, 1
    default_for :provider_code, '1G'
    default_for :cabin, 'Economy'
    default_for :xmlns, 'http://www.travelport.com/schema/air_v25_0'

    validates :segment, presence: true
    validates :adults, presence: true
    validates :cabin, inclusion: {in:[nil, 'Economy', 'Bussines', 'Premium Economy', 'First']}

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')
          xml.AirItinerary{
            xml.AirSegment(segment.to_xml_attributes.update('ProviderCode' => provider_code))
          }
          adults.times { xml.SearchPassenger('Code' => 'ADT', 'xmlns' => 'http://www.travelport.com/schema/common_v25_0', 'BookingTravelerRef' => SecureRandom.urlsafe_base64)}
          children.times { xml.SearchPassenger('Code' => 'CNN', 'Age' => 10, 'xmlns' => "http://www.travelport.com/schema/common_v25_0")} unless children.nil?
          infants.times { xml.SearchPassenger('Code' => 'INF', 'Age' => 1, 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')} unless infants.nil?
          xml.AirPricingCommand('CabinClass' => self.cabin)
        }
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Segment', 'Cabin', 'Xmlns', 'Adults', 'Children', 'Infants', 'ProviderCode').update(:xmlns => xmlns)
    end
  end
end
