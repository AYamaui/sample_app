require 'spec_helper'

describe "mail_users/new.html.erb" do
  before(:each) do
    assign(:mail_user, stub_model(MailUser,
      :mail_name => "MyString",
      :mail_email => "MyString",
      :mail_login => "MyString"
    ).as_new_record)
  end

  it "renders new mail_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mail_users_path, :method => "post" do
      assert_select "input#mail_user_mail_name", :name => "mail_user[mail_name]"
      assert_select "input#mail_user_mail_email", :name => "mail_user[mail_email]"
      assert_select "input#mail_user_mail_login", :name => "mail_user[mail_login]"
    end
  end
end
