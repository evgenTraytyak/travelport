require 'open-uri'
require 'open3'
require 'rest-client'
require 'nori'
require 'json'
require 'uri'


class RemoteTask

  attr_reader :params

  def initialize(url)
    raise "No task given." unless url

    @url = url
    response = RestClient.get(@url, accept: :xml)
    if response.code == 200
      Nori.parser = :nokogiri
      @task = Nori.parse(response)[:task]
      @params = JSON.parse @task[:params]
    else
      raise "Unable to read task from server."
    end
  end

  def user_id
    @task[:user_id]
  end

  def uid
    @task[:uid]
  end

  def name
    @task[:name]
  end

  def host
    uri = URI.parse(@url)
    "#{uri.scheme}://#{uri.host}#{":"+uri.port.to_s if uri.port != 80}"
  end

  def finish(message)
    update_task({status: 'finished', result: message})
  end

  def finish_with_error(message)
    update_task({status: 'error', result: message})
  end

private

  def update_task(params)
    RestClient.put(@url, task: params)
  end

end