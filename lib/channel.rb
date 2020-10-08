require_relative 'recipient.rb'
require 'httparty'
require 'dotenv'

Dotenv.load

class Channel < Recipient
  attr_reader :name, :slack_id, :member_count, :topic

  def initialize(name, slack_id, member_count, topic)
    @name = name
    @slack_id = slack_id
    @member_count = member_count
    @topic = topic
  end

  def details
    return [{"name" => @name, "slack_id" => @slack_id, "member_count" => @member_count, "topic" => @member_count}]
  end

  def self.load_all
    url = "	https://slack.com/api/conversations.list"
    params = {
        token: ENV['SLACK_TOKEN'],
    }
    response = self.get(url, params)
    channels_array = []
    response["channels"].each do |channel|
      channels_array.push(Channel.new(name: channel["name"], slack_id: channel["slack_id"], member_count: channel["members"].length, topic: ["topic"]["value"]))
    end
    return channels_array
  end
end
