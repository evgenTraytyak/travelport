module Travelport::Request
  class ReferenceDataRetrieveReq < Base
    attr_accessor :type_code
    attr_accessor :provider_code

    default_for :xmlns, 'http://www.travelport.com/schema/util_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.ReferenceDataSearchModifiers('MaxResults' => 50_000, 'ProviderCode' => provider_code)
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'ProviderCode').update(xmlns: xmlns)
    end
  end
end
