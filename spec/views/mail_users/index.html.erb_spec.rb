require 'spec_helper'

describe "mail_users/index.html.erb" do
  before(:each) do
    assign(:mail_users, [
      stub_model(MailUser,
        :mail_name => "Mail Name",
        :mail_email => "Mail Email",
        :mail_login => "Mail Login"
      ),
      stub_model(MailUser,
        :mail_name => "Mail Name",
        :mail_email => "Mail Email",
        :mail_login => "Mail Login"
      )
    ])
  end

  it "renders a list of mail_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mail Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mail Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mail Login".to_s, :count => 2
  end
end
