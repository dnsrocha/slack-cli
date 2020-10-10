require_relative 'test_helper'

describe "Workspace class" do

  it "returns a list of users correctly" do
    VCR.use_cassette("users_list") do
      response = SlackCLI::Workspace.new
      expect(response.users_list).must_be_kind_of Array
    end
  end

  it "returns a list of channels correctly" do
    VCR.use_cassette("channels_list") do
      response = SlackCLI::Workspace.new
      expect(response.channels_list).must_be_kind_of Array
    end
  end
end


  describe "select user or channel" do

    it "selects user correctly" do
      VCR.use_cassette("select_user") do
        response = SlackCLI::Workspace.new
        user = response.select_user("drocha")
        expect(user).must_be_kind_of SlackCLI::User
      end
    end

    it "selects channel correctly" do
      VCR.use_cassette("select channel") do
        response = SlackCLI::Workspace.new
        selected_channel = response.select_channel("seattle-stuff")
        expect(selected_channel).must_be_kind_of SlackCLI::Channel
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