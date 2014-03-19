require 'travelport'
Travelport.setup do |config|
  config.env = :test_emea          # or :production_emea or :production_apac
  config.username = 'Universal API/uAPI8720563353-8d951d63'
  config.password = 'sKjbBKWFQ6a93pX9ZjAhwd2FK'
  config.target_branch = 'P7004157'
  #config.point_of_sale = 'my_pos_id'         # by defualt this will be 'uAPI'
end
bridge = Travelport::Bridge::Air.new
response = bridge.availability_search_req({origin:'ORY', destination:'FCO', airline_code: "VY", time: DateTime.new(2014,6,9,6,45)}, {adults:1, cabin:'Economy'})

segment = response.air_segment_list.select.each do |air_segment|
  unless air_segment.codeshare_info.nil?
    air_segment.codeshare_info[:@operating_carrier] == "VY" && air_segment.codeshare_info[:@operating_flight_number] == "6250"
  end
end
