require_relative 'recipient'
require 'httparty'
require 'dotenv'

Dotenv.load

module SlackCLI
  class User < Recipient
    attr_reader :username, :real_name, :slack_id

    def initialize(username, slack_id, real_name)
      super (slack_id)

      @username = username
      @real_name = real_name
    end

    def details
      return "username: #{@username}\nSlack ID: #{@slack_id}\nreal name: #{@real_name}\n"
    end

    #will retrieve users data from the API using URL
    def self.list_all
      response = super('users.list')
      puts response
      users = []
      response["members"].each do |user|
        users << User.new(user["name"], user["real_name"], user["id"])
      end
      return users
    end

  end
end


