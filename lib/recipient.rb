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
      url = "#{URL}#{list}"
      puts url
      query_params = {token: TOKEN}
      puts query_params
      response = HTTParty.get(url, query: query_params)
      return response
    end

    def send_message(message)
      url = "#{URL}chat.postMessage"

      response = HTTParty.post(url,
                               headers: {'Content-Type' => 'application/x-www-form-urlencoded'},
                               body: {
                                   token: TOKEN,
                                   channel: slack_id,
                                   text: message
                               })
      unless response.code == 200
        raise ArgumentError.new("Request Error")
      end
      return true
    end

  end
end