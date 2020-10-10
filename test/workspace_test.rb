require_relative 'test_helper'

describe "Workspace class" do
  before do
    @users = SlackCLI::User.new("ruby", "ruby mine", "PM15QINBXFZ")
    @channel = SlackCLI::Channel.new("seattle-stuff", "U786YWDVC3D", 71, "coffee shops")
    @fake_workspace = SlackCLI::Workspace.new
  end

  it "returns a list of users correctly" do
    expect(@fake_workspace.users_list).must_be_kind_of Array
    expect(@fake_workspace.channels_list).must_be_kind_of Array
  end
end


  describe "select user" do
    before do
      @users = SlackCLI::User.new("Bot", "Slack Bot", "O0SIDJF9IA")
      @other_user = SlackCLI::User.new("ruby", "ruby mine", "PM15QINBXFZ")
      @channel = SlackCLI::Channel.new("test_channel_denise", "TPLIWDOP3D", 12, "cats")
      @other_channel = SlackCLI::Channel.new( "seattle-stuff", "U786YWDVC3D", 71, "coffee shops")
      @fake_workspace = SlackCLI::Workspace.new
    end


    it "selects user correctly" do
      VCR.use_cassette("select user") do
        response = SlackCLI::Workspace.new
        selected_user = response.select_user("Bot")
        expect(selected_user).must_be_kind_of SlackCli::Users
      end
    end

    it "selects channel correctly" do
      VCR.use_cassette("select channel") do
        response = SlackCLI::Workspace.new
        selected_channel = response.select_channel("seattle-stuff")
        expect(selected_channel).must_be_kind_of SlackCli::Channels
      end
    end


    it "returns nil if input is invalid" do
      VCR.use_cassette("user_not_found") do
        response = SlackCLI::Workspace.new
        selected_user = response.select_user("Paris")
        expect(selected_user).must_be_nil
      end

      VCR.use_cassette("channel_not_found") do
        response = SlackCLI::Workspace.new
        selected_channel = response.select_channel("breakfast")
        expect(selected_channel).must_be_nil
      end
    end
  end