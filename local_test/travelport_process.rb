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
  date_from = Time.now + (10*24*60*60)
  date_to =  Time.now + (20*24*60*60)
  query = []
  query << {from: 'LON', to: 'BCN', at: date_from}
  query << {from: 'LON', to: 'BCN', at: date_to} if return_flight
  options = {adults:   1,
             children: 0,
             infants:  0,
             cabin:    "Economy",
             provider_code: '1G'}

  puts "=== Sending Search request ==="

  response = travelport.low_fare_search(query,options)

  if response.is_a? Travelport::Response::LowFareSearchRsp
    result = TravelportResult.new(response)
    merged = result.merged
    mongo = MongoClient.new("travelport_results_1")
    mongo_id = mongo.insert({results:merged,stored_at:Time.now()})
    results = mongo.find_one({_id: mongo_id},:fields=>{:results=>{'$slice'=>[0,1]}})["results"]
    booking = results.first
    puts "=== Sending Prices request ==="
    price_response = travelport.price_details(booking,options)
    mongo = MongoClient.new('travelport_prices_1')
    puts " PRICE RECORD STORED "
    pp price_response
    mongo_id = mongo.insert({price:price_response,stored_at:Time.now()})
    price = mongo.find_one({_id: mongo_id})["price"]
    travelers = [
        {
            'first_name'=>'Michal',
            'last_name'=>'Kramer',
            'prefix'=>'Mr',
            'type'=>'ADT',
            'phone'=>'123456778',
            'email'=>'test@example.com',
            'gender'=> 'M'
        }
    ]
    puts "=== Sending Booking request ==="
    puts " PRICE RECORD RETREIVED "
    pp price
    book_response = travelport.book(price,travelers)
    mongo = MongoClient.new('travelport_bookings_1')
    mongo_id = mongo.insert({booking:book_response,stored_at:Time.now()})
    puts "Booking stored under #{mongo_id} uid."
  else
    raise 'Invalid response from Tavelport.'
  end

rescue StandardError => e
  raise e
  puts "Error: #{e}"
end

