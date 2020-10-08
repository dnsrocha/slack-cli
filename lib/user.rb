require 'dotenv'
require 'httparty'

Dotenv.load


class User
  attr_reader :name, :slack_id, :real_name

  def initialize(name, slack_id, real_name)
    @name = name
    @slack_id = slack_id
    @real_name = real_name
  end

  def details
    return [{"name" => @name,"slack_id" => @slack_id, "real_name"=> @real_name }]
  end

  # def self.load_all
  #   url = "https://slack.com/api/users.list"
  #   params = {token: ENV['SLACK_TOKEN'], }
  #   response = self.get(url, params)    --> self.get must be implemented on recipients
  #   users = []
  #   response["all_users"].each do |user|
  #     users.push(User.new(name: user["name"], slack_id: user["id"], real_name: user["real_name"]))
  #   end
  #   return users
  # end
end