require 'httparty'
require 'dotenv'

Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  TOKEN =  ENV['SLACK_TOKEN']
  URL = "https://slack.com/api/"

  def initialize(slack_id)
    @slack_id = slack_id
    @name = ""
  end

  # def self.get(url, params)
  #   response = HTTParty.get(url,query: params)
  #
  #   raise ArgumentError.new("Invalid Get Request") if response ["ok"] != true
  #
  #   return response
  # end

  def self.get
    param = {
        token: TOKEN
    }
    users = HTTParty.get(URL + "users.list", query: param)
    channels = HTTParty.get(URL + "channels.list", query: param)
    response = [users, channels]

    if response[0]["ok"] == true
      return response
    else
      raise ArgumentError.new("Invalid request")
    end
  end


  def details
    #will be implemented in child class
    raise NotImplementedError
  end

  def self.list_all
    #will be implemented in child class
    raise NotImplementedError
  end

end