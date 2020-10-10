require_relative 'test_helper.rb'

describe "class Channel" do
  #id: U786YWDVC3D | name: seattlestuff| coffee shops| member count: 71|
  before do
    @channel = SlackCLI::Channel.new(channel_name: "seattle-stuff", slack_id: U786YWDVC3D, member_count: 71, topic: "coffee shops")

    it "creates an instance of channel" do
      expect(@channel).must_be_kind_of SlackCLI::Channel
    end

    it "returns channel details correctly" do
      expect(@channel.details).must_be_kind_of String
      expect(@channel.details).must_equal "Channel name: seattle-stuff\nSlack Id: U786YWDVC3D\nTopic: coffee shops\nMember count: #{71}\n"
    end

    it "returns a list of channels" do
      VCR.use_cassette "channels_list" do
        result = SlackCLI::Channel.list_all
      end
      expect(result).must_be_kind_of Array
    end

  end
end