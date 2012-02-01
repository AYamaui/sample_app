# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SampleApp::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => "app2629184@heroku.com",
  :password => "bwlc5p0g",
  :domain => "http://smooth-frost-1157.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => '587',
  :authentication => :plain,
  :enable_starttls_auto => true
}