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
      expect(@fake_workspace.select_user("Bot")).must_be_instance_of SlackCLI::User
    end

    it "selects channel correctly" do
      expect(@fake_workspace.select_channel("TPLIWDOP3D")).must_be_instance_of SlackCLI::Channel
    end

    it "returns desired user when searching by name or id" do
      expect(@fake_workspace.select_user("O0SIDJF9IA")).must_equal "username: Bot\nSlack ID: O0SIDJF9IA\nreal name: Slack Bot"
      expect(@fake_workspace.select_user("Bot")).must_equal "username: Bot\nSlack ID: O0SIDJF9IA\nreal name: Slack Bot"
    end

    it "returns desired channel when searching by name or id" do
      expect(@fake_workspace.select_channel("U786YWDVC3D")).must_equal "channel name: seattle-stuff\nSlack ID:U786YWDVC3D\nmember count: 71\ntopic: coffee shops"
      expect(@fake_workspace.select_channel("seattle-stuff")).must_equal "channel name: seattle-stuff\nSlack ID:U786YWDVC3D\nmember count: 71\ntopic: coffee shops"
    end

    it "returns a message if input is invalid" do
      expect(@fake_workspace.select_user("lunch break")).must_equal "Invalid Channel name or ID"
      expect(@fake_workspace.select_user("@")).must_be_nil

      expect(@fake_workspace.select_channel("paris")).must_equal "Invalid Channel name or ID"
      expect(@fake_workspace.select_user("abc")).must_be_nil
    end
  end
end