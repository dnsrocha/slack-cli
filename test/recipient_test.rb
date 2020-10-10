require_relative 'test_helper.rb'

describe "Recipient class" do

  it "stores id correctly" do
    recipient_id = "GTB29AAZ"
    recipient = SlackCLI::Recipient.new(recipient_id)
    expect(recipient.slack_id).must_equal recipient_id
  end

  it "retrieves data from chosen list" do
    VCR.use_cassette "list_all" do
      response = SlackCLI::Recipient.list_all("conversations.list")
      expect(response.code).must_equal 200
    end
  end



end