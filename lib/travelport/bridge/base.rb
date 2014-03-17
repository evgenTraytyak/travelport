require 'savon'
require 'travelport/wasabi/parser'
module Travelport::Bridge
  class Base

    include Travelport::Model::DefaultFor

    attr_accessor :document
    attr_accessor :service

    def send_request(req_obj)
      req_obj.target_branch = Travelport.config.target_branch
      req_obj.billing_point_of_sale = Travelport.config.point_of_sale
      raise Travelport::Exceptions::BadRequest, "Request #{req_obj.request_name} is wrong(#{req_obj.errors.to_a})" unless req_obj.valid?

      client.call(req_obj.request_name) do
        message(request_obj.request_attributes)
      end
      # client.request(req_obj.request_name, req_obj.request_attributes) do
      #   http.headers['SOAPAction'] = ""
      #   soap.body = req_obj.request_body
      # end.body
    end

    protected
    def client
      @client ||= Savon.client do
        endpoint Travelport.config.endpoint.gsub('Service', service)
        wsdl File.join(Travelport.config.document_dir, document)
        read_timeout 300
        ssl_version :SSLv3
        basic_auth [Travelport.config.username, Travelport.config.password]
        http_headers['SOAPAction'] = ""
        convert_request_keys_to :camelcase
      end
    end
  end
end
