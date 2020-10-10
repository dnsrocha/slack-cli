require_relative 'test_helper.rb'

describe "class Channel" do
  before do
    @channel = SlackCLI::Channel.new("seattle-stuff", "U786YWDVC3D", 71, "coffee shops")
  end

  it "creates an instance of channel" do
    expect(@channel).must_be_kind_of SlackCLI::Channel
  end

  it "returns channel details correctly" do
    expect(@channel.details).must_be_kind_of String
  end

  it "returns a list of channels" do
    VCR.use_cassette "channels_list" do
      response = SlackCLI::Channel.list_all
      expect(response).must_be_kind_of Array
    end
  end
end