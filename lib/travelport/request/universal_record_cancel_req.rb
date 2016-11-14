module Travelport::Request
  class UniversalRecordCancelReq < Base
    attr_accessor :universal_record_locator_code
    attr_accessor :version

    default_for :version, 0

    default_for :xmlns, 'http://www.travelport.com/schema/universal_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns').update(xmlns: xmlns)
    end
  end
end
