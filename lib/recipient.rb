require 'httparty'
require 'dotenv'

Dotenv.load

TOKEN =  ENV['SLACK_TOKEN']
URL = "https://slack.com/api/"

module SlackCLI
  class Recipient
    attr_reader :slack_id

    def initialize(slack_id)
      @slack_id = slack_id
    end

    def self.list_all(list)
      url = "#{URL}"<<"#{list}"
      query_params = {token: TOKEN}
      response = HTTParty.get(url, query: query_params)
      return response
    end


  end
end