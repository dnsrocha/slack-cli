require_relative 'recipient.rb'
require 'httparty'
require 'table_print'

# require 'dotenv'

# Dotenv.load

class Channel < Recipient
  attr_reader :member_count, :topic

  def initialize(name, slack_id, member_count, topic)
    super(slack_id, name)
    @member_count = member_count
    @topic = topic
  end

  # def details
  #   return [{"name" => @name, "slack_id" => @slack_id, "member_count" => @member_count, "topic" => @member_count}]
  # end
  #
  # def self.load_all
  #   url = "	https://slack.com/api/conversations.list"
  #   params = {
  #       token: ENV['SLACK_TOKEN'],
  #   }
  #   response = self.get(url, params)
  #   channels_array = []
  #   response["channels"].each do |channel|
  #     channels_array.push(Channel.new(name: channel["name"], slack_id: channel["slack_id"], member_count: channel["members"].length, topic: ["topic"]["value"]))
  #   end
  #   return channels_array
  # end

  def self.get
    response = super.find {|response| response ["channels"]}
    channels = []
    response["channels"].each do |channel|
      name = channel["name"]
      slack_id = channel["id"]
      topic = channel["topic"]["value"]
      member_count = channel["num_members"]

      channels << self.new(slack_id, name, topic, member_count )
    end
    return channels
  end

  def details
    return "Channel name: #{name}\nSlack ID: #{slack_id}\nTopic: #{topic}\nMember count: #{member_count}"
  end


  def self.list_all
    tp self.get, :name, :slack_id, :topic, :member_count
  end
end
