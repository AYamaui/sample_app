require 'spec_helper'

describe "MailUsers" do
  describe "GET /mail_users" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get mail_users_path
      response.status.should be(200)
    end
  end
end
