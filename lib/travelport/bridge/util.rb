module Travelport::Bridge
  class Util < Base
    default_for :service, 'UtilService'
    default_for :document, 'util_v38_0/Util.wsdl'

    def reference_data(type_code, provider_code)
      req = Travelport::Request::ReferenceDataRetrieveReq.new do |obj|
        obj.type_code = type_code
        obj.provider_code = provider_code
      end
      # Travelport::Response::ReferenceDataRetrieveRsp.new(send_request(req))
      send_request(req)
    end
  end
end
