require 'spec_helper'

describe Travelport::Config do

  let(:config) { Travelport::Config.new }
  subject { config }
  describe "#env" do
    context "when default (:test_americas)" do
      its(:env) { should eql(:test_americas) }
      its(:endpoint) { should eql('https://americas.copy-webservices.travelport.com/B2BGateway/connect/uAPI/Service') }
      its(:username) { should be_nil }
      its(:password) { should be_nil }
      its(:target_branch) { should be_nil }
      its(:point_of_sale) { should eql('uAPI') }
      its(:uri) { should be_a(URI) }
    end
    context "when production" do
      before { config.env = :production_americas }
      its(:env)  { should eql(:production_americas) }
      its(:endpoint) { should eql('https://americas.universal-api.travelport.com/B2BGateway/connect/uAPI/Service') }
      its(:username) { should be_nil }
      its(:password) { should be_nil }
      its(:target_branch) { should be_nil }
      its(:point_of_sale) { should eql('uAPI') }
      its(:uri) { should be_a(URI) }
    end
  end

end