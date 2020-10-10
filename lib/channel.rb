require_relative 'recipient.rb'
require 'table_print'

module SlackCLI
  class Channel < Recipient
    attr_reader :channel_name, :slack_id, :member_count, :topic

    def initialize(channel_name, slack_id, member_count, topic)
      super(slack_id)

      @channel_name = channel_name
      @member_count = member_count
      @topic = topic
    end

    def details
      return "Channel name: #{@channel_name}\nSlack ID: #{@slack_id}\nTopic: #{@topic}\nMember count: #{@member_count}"
    end

    # Will retrieve the data from the API using the URL
    def self.list_all
      response = super('conversations.list')
      channels = []
      response["channels"].each do |channel|
        channels << Channel.new(channel["name"], channel["id"], channel["topic"]["value"], channel["num_members"].to_i)
      end
      return channels
    end
  end
end