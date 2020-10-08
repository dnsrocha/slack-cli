require_relative 'recipient.rb'
# require 'dotenv'
require 'httparty'
require 'table_print'
# Dotenv.load


class User < Recipient
  attr_reader :real_name

  def initialize(name, slack_id, real_name)
    super(name, slack_id)
    @real_name = real_name
  end

  # def details
  #   return [{"name" => @name,"slack_id" => @slack_id, "real_name"=> @real_name }]
  # end
  #
  # #def self.load_all
  #   #   url = "https://slack.com/api/users.list"
  #   #   params = {
  #   #       token: ENV['SLACK_TOKEN'],
  #   #   }
  #   #   response = self.get(url, params)
  #   #   users_array = []
  #   #   response["members"].each do |user|
  #   #     users_array.push(User.new(name: user["name"], slack_id: user["slack_id"], real_name: user["real_name"]))
  #   #   end
  #   #   return users_array
  #   # end

  def self.get
    response = super.find {|response| response["members"]}
    users = []
    response["members"].each do |member|
      name = member["name"]
      slack_id = member["id"]
      real_name = member["real name"]

      users << self.new(slack_id, name, real_name)
    end
    return users
  end

  def details
    return "User name: #{name}\nSlack ID: #{slack_id}\nReal name: #{real_name}\n"
  end

  def self.list_all
    tp self.get, :name, :real_name, :slack_id
  end
end



