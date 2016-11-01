module Travelport::Request
  class AirTicketingReq < Base
    attr_accessor :book
    attr_accessor :price

    default_for :xmlns, 'http://www.travelport.com/schema/air_v38_0'
    default_for :xmlns_common, 'http://www.travelport.com/schema/common_v38_0'

    def request_body
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.root do
          xml.BillingPointOfSaleInfo('OriginApplication' => billing_point_of_sale, 'xmlns' => xmlns_common)
          xml.AirReservationLocatorCode book[:air_create_reservation_rsp][:universal_record][:air_reservation][:@locator_code]
          xml.AirPricingInfoRef('Key' => book[:air_create_reservation_rsp][:universal_record][:provider_reservation_info][:@key])
          
          # air_price_rsp = price[:air_price_rsp]
          # air_price_result = air_price_rsp[:air_price_result]
          # air_pricing_solution = air_price_result[:air_pricing_solution]
          # air_pricing_infos = [air_pricing_solution[:air_pricing_info]].flatten

          # air_pricing_infos.each do |air_pricing_info|
          #   xml.AirPricingInfoRef('Key' => air_pricing_info[:@key])
          # end

          xml.AirTicketingModifiers do
            xml.FormOfPayment('xmlns' => xmlns_common, 'Type' => 'Credit') do
              xml.CreditCard('CVV' => 'CVV', 'ExpDate' => '2016-12', 'Type' => 'VI',
                             'Name' => 'TEST', 'Number' => '4012888888881881') do
                xml.BillingAddress do
                  xml.AddressName 'Charlotte'
                  xml.Street '10 Charlie Street'
                  xml.City 'Perth'
                  xml.State 'WA'
                  xml.PostalCode '6000'
                  xml.Country 'AU'
                end
              end
              xml.ProviderReservationInfoRef('ProviderReservationLevel' => true)
            end
          end
        end
      end
      builder.doc.root.children.to_xml
    end

    def request_attributes
      super.except('Xmlns', 'Book', 'Price').update(xmlns: xmlns)
    end
  end
end
