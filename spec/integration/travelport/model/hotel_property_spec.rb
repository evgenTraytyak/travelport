require 'spec_helper'

describe Travelport::Model::HotelProperty do
  let(:model_class) { Travelport::Model::HotelProperty }

  describe "##search_availability" do
    use_vcr_cassette
    let(:query) { model_class.search_availability('NYC', { checkin:Time.new + 5.days, checkout:Time.new+10.days, adults:1, rooms:1}) }
    subject { query }
    it { should be_an(Array) }
    its(:first) { should be_a(Travelport::Model::HotelProperty) }
  end

  describe "rates" do
    use_vcr_cassette
    let(:property) { model_class.new({:hotel_chain => 'CP', :hotel_code => '02743'}) }
    let(:detail_options) { { checkin:Time.new + 5.days, checkout:Time.new+10.days} }
    subject { property.rates(detail_options) }
    it { should be_an(Array) }
    its(:first) { should be_a(Travelport::Model::HotelRate) }
  end

end