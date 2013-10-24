require 'spec_helper'

describe Travelport::Response::HotelDetailsRsp do
  let(:hotel_details_rsp) { 'something' }
  let(:raw_content) { { :hotel_details_rsp => hotel_details_rsp } }
  let(:response) { Travelport::Response::HotelDetailsRsp.new(raw_content) }

  subject { response }

  its(:content_selector) { should eql(:hotel_details_rsp) }
  its(:raw_content) { should eql(hotel_details_rsp) }

end