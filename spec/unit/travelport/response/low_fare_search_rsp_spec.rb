require 'spec_helper'

describe Travelport::Response::LowFareSearchRsp do
  let(:low_fare_search_rsp) { {
    :flight_details_list => {
      :flight_details =>[]
    },
    :air_segment_list => {
      :air_segment =>[]
    },
    :fare_info_list => {
      :fare_info =>[]
    },
    :route_list => {},
    :air_pricing_solution => []
  } }
  let(:raw_content) { { :low_fare_search_rsp => low_fare_search_rsp } }
  let(:response) { Travelport::Response::LowFareSearchRsp.new(raw_content) }

  subject { response }

  its(:content_selector) { should eql(:low_fare_search_rsp) }
  its(:raw_content) { should eql(low_fare_search_rsp) }

end