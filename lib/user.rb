require_relative 'recipient.rb'
require 'httparty'

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
      users = []
      response["members"].each do |user|
        users << User.new(username: user["name"], real_name: user["real_name"], slack_id: user["id "])
      end
      return users
    end

  end
end


