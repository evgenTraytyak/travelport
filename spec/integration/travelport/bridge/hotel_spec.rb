require 'spec_helper'

describe Travelport::Bridge::Hotel do

  let(:bridge) { Travelport::Bridge::Hotel.new }

  context 'general search query' do
    use_vcr_cassette
    let(:query) { bridge.search_availability('NYC', { checkin:Time.new + 5.days, checkout:Time.new+10.days, adults:1, rooms:1}) }
    subject { query }
    it { should be_a(Travelport::Response::HotelSearchAvailabilityRsp) }
    describe "#hotel_search_results" do
      subject { query.hotel_search_results }
      it { should be_an(Array) }
      its(:first) { should be_a(Travelport::Model::HotelProperty) }
    end
  end

  context 'details query' do
    use_vcr_cassette
    let(:query) { bridge.hotel_details('CP', '02743', { checkin:Time.new + 5.days, checkout:Time.new+10.days}) }
    subject { query }
    it { should be_a(Travelport::Response::HotelDetailsRsp) }
    describe "#hotel_rate_details" do
      subject { query.hotel_rate_details }
      it { should be_an(Array) }
      its(:first) { should be_a(Travelport::Model::HotelRate) }
    end
  end

end
