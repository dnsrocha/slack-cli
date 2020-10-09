require_relative 'test_helper.rb'

describe "Workspace class" do
  before do
    @users = SlackCLI::User.new(username: "ruby", real_name: "ruby mine", slack_id: "PM15QINBXFZ")
    @channel = SlackCLI::Channel.new(channel_name: "seattle-stuff", slack_id: U786YWDVC3D, member_count: 71, topic: "coffee shops")
    fake_workspace = SlackCLI::Workspace.new


    it "returns a list of users correctly" do
      expect(fake_workspace.users_list).must_be_kind_of Array
      expect(fake_workspace.channels_list).must_be_kind_of Array
    end
  end

  describe "select user" do
    before do
      @users = SlackCLI::User.new(username: "Bot", real_name: "Slack Bot", slack_id: "O0SIDJF9IA")
      @other_user = SlackCLI::User.new(username: "ruby", real_name: "ruby mine", slack_id: "PM15QINBXFZ")
      @channel = SlackCLI::Channel.new(channel_name: "test_channel_denise", slack_id: TPLIWDOP3D, member_count: 12, topic: "cats")
      @other_channel = SlackCLI::Channel.new(channel_name: "seattle-stuff", slack_id: U786YWDVC3D, member_count: 71, topic: "coffee shops")
      fake_workspace = SlackCLI::Workspace.new

      it "selects user correctly" do
        expect(fake_workspace.select_user("Bot")).must_be_instance_of SlackCLI::User
      end

      it "selects channel correctly" do
        expect(fake_workspace.select_channel(TPLIWDOP3D)).must_be_instance_of SlackCLI::Channel
      end

      it "returns desired user when searching by name or id" do
        #perform 2 searches for the same user, must equal user data
      end

      it "returns desired channel when searching by name or id" do
        #perform 2 searches for the same channel, must equal channel data
      end

      it "returns a message if input is invalid" do
        #input is invalid user - expect "Invalid user or id blablabla"
        # input is invalid channel - expect "invalid Channel blablabla"
      end

    end
  end
end