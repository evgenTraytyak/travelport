require 'travelport'
require 'mongo'
require './local_test/mongo_client'

uid = ARGV[0]

start = Time.now

begin

  Travelport.setup do |config|
    config.env = :test_emea # or :production_emea or :production_apac
    config.username = 'Universal API/uAPI7598017805-b08999c4'
    config.password = 'Hgk9bKcCBtWJ4qjxRM9CrcmFK'
    config.target_branch = 'P108052'
    config.point_of_sale = 'UAPI' # by defualt this will be 'uAPI'
  end

  travelport = Travelport::Bridge::Air.new
  mongo = MongoClient.new('travelport_results_1')
  results = mongo.find_one({_id:BSON::ObjectId(uid)},:fields=>{:results=>{'$slice'=>[0,1]}})["results"]
  booking = results.first
  options = {adults:   1,
             children: 0,
             infants:  0,
             provider_code: '1P'}

  response = travelport.price_details(booking,options)

  pp response



rescue StandardError => e
  raise e
end

