require 'spec_helper'

describe Travelport::Bridge::Air do

  let(:bridge) { Travelport::Bridge::Air.new }

  context 'general search query' do
    use_vcr_cassette
    subject { bridge.low_fare_search([{from:'IEV', to:'NYC', at:Time.new + 5.days }, {from:'NYC', to:'IEV', at:Time.new+10.days}], {adults:1, cabin:'Economy'}) }
    it { should be_a(Travelport::Response::LowFareSearchRsp) }
  end

end