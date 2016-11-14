module Travelport::Bridge
  class UniversalRecord < Base
    default_for :service, 'UniversalRecordService'
    default_for :document, 'universal_v38_0/UniversalRecord.wsdl'

    def universal_record_info(universal_record_locator_code)
      req = Travelport::Request::UniversalRecordRetrieveReq.new do |obj|
        obj.universal_record_locator_code = universal_record_locator_code
      end
      # Travelport::Response::UniversalRecordRetrieveRsp.new(send_request(req))
      send_request(req)
    end

    def universal_record_cancel(universal_record_locator_code)
      req = Travelport::Request::UniversalRecordCancelReq.new do |obj|
        obj.universal_record_locator_code = universal_record_locator_code
      end
      # Travelport::Response::UniversalRecordCancelRsp.new(send_request(req))
      send_request(req)
    end
  end
end
