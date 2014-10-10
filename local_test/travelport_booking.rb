require 'travelport'
require 'mongo'
require './local_test/mongo_client'

uid = '5437f033422c5f37d4000001'#ARGV[0]

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
  mongo = MongoClient.new('travelport_prices_1')
  price = mongo.find_one({_id:BSON::ObjectId(uid)})["price"]
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
  book_response = travelport.book(price,travelers)

  puts book_response

rescue StandardError => e
  raise e
end

