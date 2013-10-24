require 'spec_helper'

describe Travelport::Response::HotelSearchAvailabilityRsp do
  let(:hotel_search_availability_rsp) { 'something' }
  let(:raw_content) { { :hotel_search_availability_rsp => hotel_search_availability_rsp } }
  let(:response) { Travelport::Response::HotelSearchAvailabilityRsp.new(raw_content) }

  subject { response }

  its(:content_selector) { should eql(:hotel_search_availability_rsp) }
  its(:raw_content) { should eql(hotel_search_availability_rsp) }

end