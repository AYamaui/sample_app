class Mailer < ActionMailer::Base  
  include SendGrid
  
  default :from => "app2629184@heroku.com"
  
  sendgrid_category :use_subject_lines
  sendgrid_enable :ganalytics, :opentrack
    
  def welcome_email(user)
    mail( :to => user.email,
    :subject => "Thanks for signing up" )
  end
  
end
