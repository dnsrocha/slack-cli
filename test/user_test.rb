require_relative 'test_helper'
require_relative '../lib/user'

describe 'User class' do
  describe 'self.get' do
    it "get list of users" do
      list = {}
      VCR.use_cassette("users_list") do
        list = User.get("https://slack.com/api/users.list")
      end

      expect(list).must_be_kind_of HTTParty::Response
      expect(list["ok"]).must_equal true
    end

    it 'raises an error if a call fails' do
      VCR.use_cassette("fail") do
        expect{USER.get("https://slack.com/api/failcall")}.must_raise ArgumentError
      end
    end
  end
end
