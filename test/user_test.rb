require_relative 'test_helper'

describe "User Class" do
  before do
    @users = SlackCLI::User.new("ruby", "PM15QINBXFZ", "ruby mine")
  end

  it "Creates an instance of Users" do
    expect(@users).must_be_kind_of SlackCLI::User
  end

  it "Return user details correctly" do
    expect(@users.details).must_be_kind_of String
    expect(@users.username).must_equal "ruby"
    expect(@users.slack_id).must_equal "PM15QINBXFZ"
  end

  it "Returns a list of users" do
    VCR.use_cassette "user_list" do
      result = SlackCLI::User.list_all
      expect(result).must_be_kind_of Array
    end
  end
end