require 'spec_helper'

describe Travelport do

  describe "##config" do
    subject { Travelport.config }
    it { should be_a(Travelport::Config) }
  end

  describe "##setup" do
    subject { Travelport.config }
    context "when accept all :test env defaults" do
      before do
        Travelport.setup do |config|
          config.env = :test_americas
        end
      end
      its(:env) { should eql(:test_americas) }
      its(:endpoint) { should eql('https://americas.copy-webservices.travelport.com/B2BGateway/connect/uAPI/Service') }
      its(:username) { should be_nil }
      its(:password) { should be_nil }
      its(:target_branch) {  should be_nil }
      its(:point_of_sale) { should eql('uAPI') }
    end
    context "when accept all :production_americas env defaults" do
      before do
        Travelport.setup do |config|
          config.env = :production_americas
        end
      end
      its(:env)  { should eql(:production_americas) }
      its(:endpoint) { should eql('https://americas.universal-api.travelport.com/B2BGateway/connect/uAPI/Service') }
      its(:username) { should be_nil }
      its(:password) { should be_nil }
      its(:target_branch) { should be_nil }
      its(:point_of_sale) { should eql('uAPI') }
    end
    context "when all options explicitly set" do
      before do
        Travelport.setup do |config|
          config.env = :production_americas
          config.endpoint = 'http://someehere.else.com'
          config.username = 'my_uid'
          config.password = 'my_pwd'
          config.target_branch = '3'
          config.point_of_sale = '33'
        end
      end
      its(:env) { should eql(:production_americas) }
      its(:endpoint) { should eql('http://someehere.else.com') }
      its(:username) { should eql('my_uid') }
      its(:password) { should eql('my_pwd') }
      its(:target_branch) { should eql('3') }
      its(:point_of_sale) { should eql('33') }
    end
  end

end