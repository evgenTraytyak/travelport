module Travelport::Request
  class HotelDetailsReq < Base

    attr_accessor :chain_code
    attr_accessor :property_id
    attr_accessor :availability
    attr_accessor :adults
    attr_accessor :rate_rule
    attr_accessor :rate_category
    attr_accessor :checkin
    attr_accessor :checkout

    default_for :adults, 1
    default_for :availability, 'Available'
    default_for :rate_rule, 'Complete'
    default_for :rate_category, 'All'
    default_for :xmlns, 'http://www.travelport.com/schema/hotel_v28_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v28_0'

    validates_presence_of :chain_code
    validates_presence_of :property_id

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root {
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.HotelProperty('HotelChain' => chain_code, 'HotelCode' => property_id, 'Availability' => availability)
          xml.HotelDetailsModifiers('NumberOfAdults' => adults, 'RateRuleDetail' => rate_rule) {
            xml.HotelStay {
              xml.CheckinDate checkin.strftime("%Y-%m-%d")
              xml.CheckoutDate checkout.strftime("%Y-%m-%d")
            }
            xml.RateCategory rate_category
          }
        }
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'ChainCode', 'PropertyId', 'Availability', 'Adults', 'RateRule', 'RateCategory', 'Checkin', 'Checkout').update(:xmlns => xmlns)
    end


  end
end