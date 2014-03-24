module Travelport::Request
  class AvailabilitySearchReq < Base
    attr_accessor :sector
    attr_accessor :adults
    attr_accessor :children
    attr_accessor :infants
    attr_accessor :cabin
    attr_accessor :provider_code
    attr_accessor :airline_code

    default_for :adults, 1
    default_for :infants, 1
    default_for :children, 1
    default_for :airline_code, 'VL'
    default_for :provider_code, '1G'
    default_for :cabin, 'Economy'
    default_for :xmlns, 'http://www.travelport.com/schema/air_v25_0'

    validates :sector, presence: true
    validates :adults, presence: true

    validates :cabin, inclusion: {in:[nil, 'Economy', 'Bussines', 'Premium Economy', 'First']}

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root{
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')
          xml.SearchAirLeg {
            xml.SearchOrigin {
              xml.CityOrAirport('Code' => sector[:origin], 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')
            }
            xml.SearchDestination {
              xml.CityOrAirport('Code' => sector[:destination], 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')
            }
            xml.SearchDepTime('PreferredTime' => sector[:time].to_s)
          }
          xml.AirSearchModifiers {
            xml.PreferredProviders {
              xml.Provider('Code' => provider_code, 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')
            }
            if sector[:airline_code].present?
              xml.ProhibitedCarriers {
                xml.Carrier('Code' => sector[:airline_code], 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')
              }
            end
        }

        # adults.times { xml.SearchPassenger('Code' => 'ADT', 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')}
        # children.times { xml.SearchPassenger('Code' => 'CNN', 'Age' => 10, 'xmlns' => "http://www.travelport.com/schema/common_v25_0")} unless children.nil?
        # infants.times { xml.SearchPassenger('Code' => 'INF', 'Age' => 1, 'xmlns' => 'http://www.travelport.com/schema/common_v25_0')} unless infants.nil?
      }
    end
    builder.doc.root.children.to_xml
  end

  def request_attributes
    super.except('Sector', 'Cabin', 'Xmlns', 'Adults', 'Children', 'Infants', 'ProviderCode', 'AirlineCode').update(:xmlns => xmlns)
  end


end
end
