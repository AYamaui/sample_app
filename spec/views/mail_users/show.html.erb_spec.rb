require 'spec_helper'

describe "mail_users/show.html.erb" do
  before(:each) do
    @mail_user = assign(:mail_user, stub_model(MailUser,
      :mail_name => "Mail Name",
      :mail_email => "Mail Email",
      :mail_login => "Mail Login"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mail Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mail Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mail Login/)
  end
end
