#----twitter
require 'twitter/authentication_helpers'
#----

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  #----twitter
   include Twitter::AuthenticationHelpers
  
  #Handle the 'Twitter:Unauthorized' exception with the force_sign_in action
  #rescue_from Twitter::Unauthorized, :with => :force_sign_in
    
  private

  #Create a new consumer instance by passing it a configuration hash
  def oauth_consumer
    @oauth_consumer ||= OAuth::Consumer.new('8HMEWgi9jCjSS8DzWyX8Q', 'N96T1OPRx5vQgCIzoKVMKntXcALkckNmt4mCwaKioGA', :site => 'http://api.twitter.com', :request_endpoint => 'http://api.twitter.com', :sign_in => false)
  end

  #Set the Twitter OAuth credentials
  def client
    if current_user.twitter_access_token.nil?
      Twitter.configure do |config|
        config.consumer_key = '8HMEWgi9jCjSS8DzWyX8Q'
        config.consumer_secret = 'N96T1OPRx5vQgCIzoKVMKntXcALkckNmt4mCwaKioGA'
        #The session['access_token/secret'] variables were assigned in the callback action
        config.oauth_token = session['twitter_access_token']
        config.oauth_token_secret = session['twitter_access_secret']
      end
    else
      #binding.pry
      Twitter.configure do |config|
        config.consumer_key = '8HMEWgi9jCjSS8DzWyX8Q'
        config.consumer_secret = 'N96T1OPRx5vQgCIzoKVMKntXcALkckNmt4mCwaKioGA'
        #The session['access_token/secret'] variables were assigned in the callback action
        config.oauth_token = current_user.twitter_access_token
        config.oauth_token_secret = current_user.twitter_access_secret
      end
    end
    #Create a client instance with the credentials seted before
    @client ||= Twitter::Client.new
    
  end
  #Declare the controller method client as a heleper
  helper_method :client

  def force_sign_in(exception)
    reset_session
    flash[:error] = "It seems your credentials are not good anymore. Please sign in again."
    #It has to redirect to the user profile
    redirect_to 'http://localhost:3000/users/101'
  end
  #----
  
  #hola
  
end





