require 'travelport'
require 'mongo'
require './workers/travelport_result'
require './workers/remote_task'
require './workers/mongo_client'

task_url = if defined? params #we are in IronIO environment
             params[:task_url]
           else #we are in local environment
             ARGV[0]
           end

start = Time.now

begin

  @remote_task = RemoteTask.new(task_url)
  credentials = @remote_task.params['credentials']
  search = @remote_task.params['search']
  user_id = @remote_task.user_id

  Travelport.setup do |config|
    config.env = :test_emea # or :production_emea or :production_apac
    config.username = credentials['username'] #Universal API/uAPI7598017805-b08999c4'
    config.password = credentials['password'] #'Hgk9bKcCBtWJ4qjxRM9CrcmFK'
    config.target_branch = credentials['branch'] #P108052'
    config.point_of_sale = 'UAPI' # by defualt this will be 'uAPI'
  end

  travelport = Travelport::Bridge::Air.new
  return_flight = true
  date_format = '%m/%d/%Y'
  date_from = Date.strptime(search['date_from'],date_format).to_time
  date_to = Date.strptime(search['date_to'],date_format).to_time
  query = []
  query << {from: search['airport_from'], to: search['airport_to'], at: date_from}
  query << {from: search['airport_to'], to: search['airport_from'], at: date_to} if return_flight
  options = {adults:   search['adults_number'].to_i,
             children: search['children_number'].to_i,
             infants:  search['infants_number'].to_i,
             cabin:    search['cabin_class'],
             provider_code: '1P'}

  response = travelport.low_fare_search(query,options)

  if response.is_a? Travelport::Response::LowFareSearchRsp
    result = TravelportResult.new(response)
    merged = result.merged
    mongo = MongoClient.new("travelport_results_#{user_id}")
    mongo_id = mongo.insert({results:merged,stored_at:Time.now()})
    @remote_task.finish(mongo_id)
  else
    raise 'Invalid response from Tavelport.'
  end

rescue StandardError => e
  puts "Error: #{e}"
  @remote_task.finish_with_error(e.message) if @remote_task
end

