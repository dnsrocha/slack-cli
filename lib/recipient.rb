require 'httparty'
require 'dotenv'

Dotenv.load

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id)
    @slack_id = slack_id
    @name = ""
  end

  def self.get(url, params)
    response = HTTParty.get(url,query: params)

    raise ArgumentError.new("Invalid Get Request") if response ["ok"] != true

    return response
  end

  def details
    #will be implemented in child class
  end

  def self.list_all
    #will be implemented in child class
  end

end