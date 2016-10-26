# -*- encoding: utf-8 -*-
# stub: travelport 0.0.8 ruby lib vendor/gems/savon/lib

Gem::Specification.new do |s|
  s.name = "travelport"
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib", "vendor/gems/savon/lib"]
  s.authors = ["Mikhail Bondar", "Paul Gallagher", "Nicholas Zaillian"]
  s.date = "2016-10-25"
  s.description = "travelport.com API wrapper for Ruby"
  s.email = ["m.bondar@yahoo.com", "gallagher.paul@gmail.com", "nzaillian@gmail.com"]
  s.files = [".gitignore", ".idea/runConfigurations/All_tests_in_spec__travelport.xml", ".idea/runConfigurations/Run_spec__air_spec___travelport.xml", ".rspec", ".travis.yml", "Gemfile", "Guardfile", "LICENSE", "README.rdoc", "Rakefile", "lib/travelport.rb", "lib/travelport/bridge.rb", "lib/travelport/bridge/air.rb", "lib/travelport/bridge/base.rb", "lib/travelport/bridge/hotel.rb", "lib/travelport/config.rb", "lib/travelport/exceptions.rb", "lib/travelport/model.rb", "lib/travelport/model/air_segment.rb", "lib/travelport/model/attribute_methods.rb", "lib/travelport/model/base.rb", "lib/travelport/model/block_initialization.rb", "lib/travelport/model/default_for.rb", "lib/travelport/model/fare_info.rb", "lib/travelport/model/flight_details.rb", "lib/travelport/model/hotel_property.rb", "lib/travelport/model/hotel_rate.rb", "lib/travelport/model/price.rb", "lib/travelport/model/pricing_solution.rb", "lib/travelport/request.rb", "lib/travelport/request/air_create_reservation_req.rb", "lib/travelport/request/air_price_req.rb", "lib/travelport/request/base.rb", "lib/travelport/request/hotel_details_req.rb", "lib/travelport/request/hotel_search_availability_req.rb", "lib/travelport/request/low_fare_search_req.rb", "lib/travelport/response.rb", "lib/travelport/response/base.rb", "lib/travelport/response/hotel_details_rsp.rb", "lib/travelport/response/hotel_search_availability_rsp.rb", "lib/travelport/response/low_fare_search_rsp.rb", "lib/travelport/version.rb", "lib/travelport/wasabi/parser.rb", "local_test/mongo.yml", "local_test/mongo_client.rb", "local_test/remote_task.rb", "local_test/travelport_booking.rb", "local_test/travelport_pricing.rb", "local_test/travelport_process.rb", "local_test/travelport_result.rb", "local_test/travelport_search.rb", "spec/fixtures/cassettes/Travelport_Bridge_Air/general_search_query.yml", "spec/fixtures/cassettes/Travelport_Bridge_Hotel/details_query.yml", "spec/fixtures/cassettes/Travelport_Bridge_Hotel/details_query_not_available.yml", "spec/fixtures/cassettes/Travelport_Bridge_Hotel/general_search_query.yml", "spec/fixtures/cassettes/Travelport_Model_HotelProperty/_search_availability.yml", "spec/fixtures/cassettes/Travelport_Model_HotelProperty/rates.yml", "spec/integration/credentials_spec.rb", "spec/integration/travelport/bridge/air_spec.rb", "spec/integration/travelport/bridge/hotel_spec.rb", "spec/integration/travelport/model/hotel_property_spec.rb", "spec/spec_helper.rb", "spec/support/credentials_helper.rb", "spec/unit/travelport/config_spec.rb", "spec/unit/travelport/response/hotel_details_rsp_spec.rb", "spec/unit/travelport/response/hotel_search_availability_rsp_spec.rb", "spec/unit/travelport/response/low_fare_search_rsp_spec.rb", "spec/unit/travelport_spec.rb", "travelport.gemspec", "vendor/gems/savon/.gitignore", "vendor/gems/savon/.rspec", "vendor/gems/savon/.travis.yml", "vendor/gems/savon/.yardopts", "vendor/gems/savon/CHANGELOG.md", "vendor/gems/savon/Gemfile", "vendor/gems/savon/LICENSE", "vendor/gems/savon/README.md", "vendor/gems/savon/Rakefile", "vendor/gems/savon/lib/savon.rb", "vendor/gems/savon/lib/savon/client.rb", "vendor/gems/savon/lib/savon/config.rb", "vendor/gems/savon/lib/savon/core_ext/string.rb", "vendor/gems/savon/lib/savon/error.rb", "vendor/gems/savon/lib/savon/hooks/group.rb", "vendor/gems/savon/lib/savon/hooks/hook.rb", "vendor/gems/savon/lib/savon/http/error.rb", "vendor/gems/savon/lib/savon/log_message.rb", "vendor/gems/savon/lib/savon/logger.rb", "vendor/gems/savon/lib/savon/model.rb", "vendor/gems/savon/lib/savon/null_logger.rb", "vendor/gems/savon/lib/savon/soap.rb", "vendor/gems/savon/lib/savon/soap/fault.rb", "vendor/gems/savon/lib/savon/soap/invalid_response_error.rb", "vendor/gems/savon/lib/savon/soap/request.rb", "vendor/gems/savon/lib/savon/soap/request_builder.rb", "vendor/gems/savon/lib/savon/soap/response.rb", "vendor/gems/savon/lib/savon/soap/xml.rb", "vendor/gems/savon/lib/savon/version.rb", "vendor/gems/savon/spec/fixtures/gzip/message.gz", "vendor/gems/savon/spec/fixtures/response/another_soap_fault.xml", "vendor/gems/savon/spec/fixtures/response/authentication.xml", "vendor/gems/savon/spec/fixtures/response/header.xml", "vendor/gems/savon/spec/fixtures/response/list.xml", "vendor/gems/savon/spec/fixtures/response/multi_ref.xml", "vendor/gems/savon/spec/fixtures/response/soap_fault.xml", "vendor/gems/savon/spec/fixtures/response/soap_fault12.xml", "vendor/gems/savon/spec/fixtures/response/taxcloud.xml", "vendor/gems/savon/spec/fixtures/wsdl/authentication.xml", "vendor/gems/savon/spec/fixtures/wsdl/lower_camel.xml", "vendor/gems/savon/spec/fixtures/wsdl/multiple_namespaces.xml", "vendor/gems/savon/spec/fixtures/wsdl/multiple_types.xml", "vendor/gems/savon/spec/fixtures/wsdl/taxcloud.xml", "vendor/gems/savon/spec/integration/request_spec.rb", "vendor/gems/savon/spec/savon/client_spec.rb", "vendor/gems/savon/spec/savon/config_spec.rb", "vendor/gems/savon/spec/savon/core_ext/string_spec.rb", "vendor/gems/savon/spec/savon/hooks/group_spec.rb", "vendor/gems/savon/spec/savon/hooks/hook_spec.rb", "vendor/gems/savon/spec/savon/http/error_spec.rb", "vendor/gems/savon/spec/savon/logger_spec.rb", "vendor/gems/savon/spec/savon/model_spec.rb", "vendor/gems/savon/spec/savon/savon_spec.rb", "vendor/gems/savon/spec/savon/soap/fault_spec.rb", "vendor/gems/savon/spec/savon/soap/request_builder_spec.rb", "vendor/gems/savon/spec/savon/soap/request_spec.rb", "vendor/gems/savon/spec/savon/soap/response_spec.rb", "vendor/gems/savon/spec/savon/soap/xml_spec.rb", "vendor/gems/savon/spec/savon/soap_spec.rb", "vendor/gems/savon/spec/spec_helper.rb", "vendor/gems/savon/spec/support/endpoint.rb", "vendor/gems/savon/spec/support/fixture.rb", "wsdl/SessionContext_v1/SessionContext_v1.xsd", "wsdl/air_v38_0/Air.wsdl", "wsdl/air_v38_0/Air.xsd", "wsdl/air_v38_0/AirAbstract.wsdl", "wsdl/air_v38_0/AirReqRsp.xsd", "wsdl/air_v38_0/Kestrel.xsd", "wsdl/common_v38_0/Common.xsd", "wsdl/common_v38_0/CommonReqRsp.xsd", "wsdl/common_v38_0/Kestrel.xsd", "wsdl/cruise_v38_0/Cruise.xsd", "wsdl/cruise_v38_0/CruiseReqRsp.xsd", "wsdl/cruise_v38_0/Kestrel.xsd", "wsdl/filefinishing_v8_0/FileFinishing.wsdl", "wsdl/filefinishing_v8_0/FileFinishing.xsd", "wsdl/filefinishing_v8_0/FileFinishingAbstract.wsdl", "wsdl/filefinishing_v8_0/FileFinishingReqRsp.xsd", "wsdl/filefinishing_v8_0/Kestrel.xsd", "wsdl/gdsQueue_v38_0/GDSQueue.wsdl", "wsdl/gdsQueue_v38_0/GDSQueue.xsd", "wsdl/gdsQueue_v38_0/GDSQueueAbstract.wsdl", "wsdl/gdsQueue_v38_0/Kestrel.xsd", "wsdl/hotel_v38_0/Hotel.wsdl", "wsdl/hotel_v38_0/Hotel.xsd", "wsdl/hotel_v38_0/HotelAbstract.wsdl", "wsdl/hotel_v38_0/HotelReqRsp.xsd", "wsdl/hotel_v38_0/Kestrel.xsd", "wsdl/passive_v38_0/Kestrel.xsd", "wsdl/passive_v38_0/Passive.xsd", "wsdl/rail_v38_0/Kestrel.xsd", "wsdl/rail_v38_0/Rail.wsdl", "wsdl/rail_v38_0/Rail.xsd", "wsdl/rail_v38_0/RailAbstract.wsdl", "wsdl/rail_v38_0/RailReqRsp.xsd", "wsdl/reporting_v8_0/Kestrel.xsd", "wsdl/reporting_v8_0/Reporting.wsdl", "wsdl/reporting_v8_0/Reporting.xsd", "wsdl/reporting_v8_0/ReportingAbstract.wsdl", "wsdl/reporting_v8_0/ReportingReqRsp.xsd", "wsdl/sharedBooking_v38_0/Kestrel.xsd", "wsdl/sharedBooking_v38_0/SharedBooking.wsdl", "wsdl/sharedBooking_v38_0/SharedBooking.xsd", "wsdl/sharedBooking_v38_0/SharedBookingAbstract.wsdl", "wsdl/sharedBooking_v38_0/SharedBookingReqRsp.xsd", "wsdl/sharedUprofile_v20_0/CustomerProfileAbstract.wsdl", "wsdl/sharedUprofile_v20_0/Kestrel.xsd", "wsdl/sharedUprofile_v20_0/SharedUProfile.wsdl", "wsdl/sharedUprofile_v20_0/UProfileAdminReqRsp.xsd", "wsdl/sharedUprofile_v20_0/UProfileCoreReqRsp.xsd", "wsdl/sharedUprofile_v20_0/UProfileSearchReqRsp.xsd", "wsdl/sharedUprofile_v20_0/UProfileShared.xsd", "wsdl/system_v32_0/Kestrel.xsd", "wsdl/system_v32_0/System.wsdl", "wsdl/system_v32_0/System.xsd", "wsdl/system_v32_0/SystemAbstract.wsdl", "wsdl/terminal_v33_0/Kestrel.xsd", "wsdl/terminal_v33_0/Terminal.wsdl", "wsdl/terminal_v33_0/Terminal.xsd", "wsdl/terminal_v33_0/TerminalAbstract.wsdl", "wsdl/universal_v38_0/Kestrel.xsd", "wsdl/universal_v38_0/UniversalRecord.wsdl", "wsdl/universal_v38_0/UniversalRecord.xsd", "wsdl/universal_v38_0/UniversalRecordAbstract.wsdl", "wsdl/universal_v38_0/UniversalRecordReqRsp.xsd", "wsdl/uprofileCommon_v30_0/Kestrel.xsd", "wsdl/uprofileCommon_v30_0/UprofileCommon.xsd", "wsdl/uprofileCommon_v30_0/UprofileCommonReqRsp.xsd", "wsdl/uprofileCommon_v30_0/util_v38_0/Kestrel.xsd", "wsdl/uprofileCommon_v30_0/util_v38_0/Util.wsdl", "wsdl/uprofileCommon_v30_0/util_v38_0/Util.xsd", "wsdl/uprofileCommon_v30_0/util_v38_0/UtilAbstract.wsdl", "wsdl/uprofile_v37_0/Kestrel.xsd", "wsdl/uprofile_v37_0/UProfile.wsdl", "wsdl/uprofile_v37_0/UProfile.xsd", "wsdl/uprofile_v37_0/UProfileAbstract.wsdl", "wsdl/uprofile_v37_0/UProfileCoreReqRsp.xsd", "wsdl/uprofile_v37_0/UProfileReqRsp.xsd", "wsdl/util_v38_0/Kestrel.xsd", "wsdl/util_v38_0/Util.wsdl", "wsdl/util_v38_0/Util.xsd", "wsdl/util_v38_0/UtilAbstract.wsdl", "wsdl/vehicle_v38_0/Kestrel.xsd", "wsdl/vehicle_v38_0/Vehicle.wsdl", "wsdl/vehicle_v38_0/Vehicle.xsd", "wsdl/vehicle_v38_0/VehicleAbstract.wsdl", "wsdl/vehicle_v38_0/VehicleReqRsp.xsd"]
  s.homepage = "https://github.com/evendis/travelport"
  s.rubygems_version = "2.4.8"
  s.summary = "Provides a simple interface to the travelport.com API for travel listings and booking"
  s.test_files = ["spec/fixtures/cassettes/Travelport_Bridge_Air/general_search_query.yml", "spec/fixtures/cassettes/Travelport_Bridge_Hotel/details_query.yml", "spec/fixtures/cassettes/Travelport_Bridge_Hotel/details_query_not_available.yml", "spec/fixtures/cassettes/Travelport_Bridge_Hotel/general_search_query.yml", "spec/fixtures/cassettes/Travelport_Model_HotelProperty/_search_availability.yml", "spec/fixtures/cassettes/Travelport_Model_HotelProperty/rates.yml", "spec/integration/credentials_spec.rb", "spec/integration/travelport/bridge/air_spec.rb", "spec/integration/travelport/bridge/hotel_spec.rb", "spec/integration/travelport/model/hotel_property_spec.rb", "spec/spec_helper.rb", "spec/support/credentials_helper.rb", "spec/unit/travelport/config_spec.rb", "spec/unit/travelport/response/hotel_details_rsp_spec.rb", "spec/unit/travelport/response/hotel_search_availability_rsp_spec.rb", "spec/unit/travelport/response/low_fare_search_rsp_spec.rb", "spec/unit/travelport_spec.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["> 1.1.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 2.1.1"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9.2"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<activemodel>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<httpclient>, ["~> 2.3.1"])
      s.add_runtime_dependency(%q<nori>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<httpi>, [">= 2.0.0"])
      s.add_runtime_dependency(%q<wasabi>, [">= 2.5.0"])
      s.add_runtime_dependency(%q<akami>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<gyoku>, ["~> 0.4.5"])
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_development_dependency(%q<mocha>, ["~> 0.11"])
      s.add_development_dependency(%q<timecop>, ["~> 0.3"])
    else
      s.add_dependency(%q<bundler>, ["> 1.1.0"])
      s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_dependency(%q<guard-rspec>, ["~> 2.1.1"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9.2"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<activemodel>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<httpclient>, ["~> 2.3.1"])
      s.add_dependency(%q<nori>, ["~> 1.1.0"])
      s.add_dependency(%q<httpi>, [">= 2.0.0"])
      s.add_dependency(%q<wasabi>, [">= 2.5.0"])
      s.add_dependency(%q<akami>, ["~> 1.2.0"])
      s.add_dependency(%q<gyoku>, ["~> 0.4.5"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<mocha>, ["~> 0.11"])
      s.add_dependency(%q<timecop>, ["~> 0.3"])
    end
  else
    s.add_dependency(%q<bundler>, ["> 1.1.0"])
    s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
    s.add_dependency(%q<rspec>, ["~> 2.11.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.11"])
    s.add_dependency(%q<guard-rspec>, ["~> 2.1.1"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9.2"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<activemodel>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<httpclient>, ["~> 2.3.1"])
    s.add_dependency(%q<nori>, ["~> 1.1.0"])
    s.add_dependency(%q<httpi>, [">= 2.0.0"])
    s.add_dependency(%q<wasabi>, [">= 2.5.0"])
    s.add_dependency(%q<akami>, ["~> 1.2.0"])
    s.add_dependency(%q<gyoku>, ["~> 0.4.5"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<mocha>, ["~> 0.11"])
    s.add_dependency(%q<timecop>, ["~> 0.3"])
  end
end
