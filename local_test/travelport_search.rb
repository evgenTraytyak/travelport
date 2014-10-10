require 'travelport'
require 'mongo'
require './local_test/mongo_client'
require './local_test/travelport_result'

task_url = if defined? params #we are in IronIO environment
             params[:task_url]
           else #we are in local environment
             ARGV[0]
           end

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
  return_flight = false
  date_format = '%m/%d/%Y'
  date_from = Time.now + (7*24*60*60)
  date_to =  Time.now + (14*24*60*60)
  query = []
  query << {from: 'MUC', to: 'BCN', at: date_from}
  query << {from: 'SXF', to: 'DUB', at: date_to} if return_flight
  options = {adults:   2,
             children: 0,
             infants:  0,
             cabin:    "Economy",
             provider_code: ['1G']}

  response = travelport.low_fare_search(query,options)

  if response.is_a? Travelport::Response::LowFareSearchRsp
    result = TravelportResult.new(response)
    merged = result.merged
    mongo = MongoClient.new("travelport_results_1")
    mongo_id = mongo.insert({results:merged,stored_at:Time.now()})
  else
    raise 'Invalid response from Tavelport.'
  end

rescue StandardError => e
  puts "Error: #{e}"
end

