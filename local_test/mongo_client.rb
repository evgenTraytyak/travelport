require 'mongo'
class MongoClient

  attr_accessor :client
  attr_accessor :database
  attr_accessor :collection

  def find_one(id = nil, opts = {})
    @collection.find_one id, opts
  end

  def find(selector = {}, opts = {})
    @collection.find selector, opts
  end

  def insert(document)
    @collection.insert document
  end

  def update(selector, document, opts = {})
    @collection.update selector, document, opts
  end

  def remove(selector = {}, opts = {})
    @collection.remove selector, opts
  end



  def initialize(collection)
    @client = client_factory
    @database = @client.db
    @collection = @database.collection(collection)
  end

private

  def mongo_uri
    config = YAML.load(File.open(File.join('local_test', 'mongo.yml')))[determine_environment]
    "mongodb://#{config['username']}:#{config['password']}@#{config['host']}/#{config['database']}"
  end

  def client_factory
    Mongo::MongoClient.from_uri(mongo_uri)
  end

  def determine_environment
    return 'mongolab'
    in_rails = defined?Rails
    in_rails ? Rails.env : ENV['REPORT_BUILDER_ENV'] || 'mongolab'
  end
end