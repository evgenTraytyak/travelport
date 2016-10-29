module Travelport::Request
  class HotelMediaLinksReq < Base
    attr_accessor :chain_code
    attr_accessor :property_id

    default_for :xmlns, 'http://www.travelport.com/schema/hotel_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    validates_presence_of :chain_code
    validates_presence_of :property_id

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.HotelProperty('HotelChain' => chain_code, 'HotelCode' => property_id)
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'ChainCode', 'PropertyId').update(xmlns: xmlns)
    end
  end
end
