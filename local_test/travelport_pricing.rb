require 'travelport'
require 'mongo'
require './local_test/mongo_client'

uid = '54380e49422c5f0b04000001'#ARGV[0]

start = Time.now

begin

  Travelport.setup do |config|
    config.env = :test_emea # or :production_emea or :production_apac
    config.username = 'Universal API/uAPI5164290370'
    config.password = 'YBkG2sWtFY8eWb3s9qsSzP7BZ'
    config.target_branch = 'P105144'
    config.point_of_sale = 'UAPI' # by defualt this will be 'uAPI'
  end

  travelport = Travelport::Bridge::Air.new
  mongo = MongoClient.new('travelport_results_1')
  results = mongo.find_one({_id:BSON::ObjectId(uid)},:fields=>{:results=>{'$slice'=>[0,1]}})["results"]
  pp results
  booking = results.first
  options = {adults:   1,
             children: 0,
             infants:  0,
             provider_code: '1G'}

  price_response = travelport.price_details(booking,options)
  mongo = MongoClient.new('travelport_prices_1')
  mongo_id = mongo.insert({price:price_response,stored_at:Time.now()})
  pp mongo_id



rescue StandardError => e
  raise e
end

