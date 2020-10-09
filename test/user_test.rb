require_relative 'test_helper'
# require_relative '../lib/user'

describe "User Class" do
  describe "User instantiation" do
    before do
      @users = SlackCLI::User.new(username: "ruby", real_name: "ruby mine", slack_id: "PM15QINBXFZ")


      it "Creates an instance of Users" do
       expect(@users).must_be_kind_of SlackCLI::User
      end
    end


  end
end