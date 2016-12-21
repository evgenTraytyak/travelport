module Travelport::Request
  class AirTicketingReq < Base
    attr_accessor :air_reservation_locator_code
    attr_accessor :air_pricing_info_ref
    attr_accessor :card

    default_for :xmlns, 'http://www.travelport.com/schema/air_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.AirReservationLocatorCode locator_code
          xml.AirPricingInfoRef('Key' => air_pricing_info_ref)

          xml.AirTicketingModifiers do
            xml.FormOfPayment('xmlns' => xmlns_common, 'Type' => 'Credit') do
              xml.CreditCard('CVV' => card['cvv'], 'ExpDate' => card['expiration_date'],
                             'Number' => card['number'], 'Name' => card['name'], 'Type' => card['type'])
              xml.ProviderReservationInfoRef('ProviderReservationLevel' => true)
            end
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Card', 'AirReservationLocatorCode', 'AirPricingInfoRef').update(xmlns: xmlns)
    end
  end
end
