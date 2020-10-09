require_relative 'test_helper'

describe "User Class" do
    before do
      @users = SlackCLI::User.new(username: "ruby", real_name: "ruby mine", slack_id: "PM15QINBXFZ")


      it "Creates an instance of Users" do
       expect(@users).must_be_kind_of SlackCLI::User
      end

      it "Return user details correctly" do
        expect(@users.details).must_be_kind_of String

        expect(@users.details).must_equal "username: ruby\nSlack ID: PM15QINBXFZ\nreal name: ruby mine"
      end

      it "Returns a list of users" do
        VCR.use_cassette "user_list" do
          result = SlackCLI::User.list_all
        end
        expect(result).must_be_kind_of Array
      end

    end
end