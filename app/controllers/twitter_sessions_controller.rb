class TwitterSessionsController < ApplicationController

  
  def new
    #binding.pry
    @twitter_user = client.user if twitter_signed_in?
  end
  
  def create
      #binding.pry
      request_token = oauth_consumer.get_request_token(:oauth_callback => callback_url)
      session['request_token'] = request_token.token
      session['request_secret'] = request_token.secret
      #Redirects to the url where the user will grant or denny acces to their data
      redirect_to request_token.authorize_url
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  def callback   
    request_token = OAuth::RequestToken.new(oauth_consumer, session['request_token'], session['request_secret'])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    
    #binding.pry
    current_user.access_token = access_token.token
    current_user.access_secret = access_token.secret
    current_user.save
    #current_user.update_attribute(:access_token, access_token.token)
    #current_user.update_attribute(:access_secret, access_token.secret)
    
    reset_session
    session['access_token'] = access_token.token
    session['access_secret'] = access_token.secret
    
    twitter_user = client.verify_credentials
    twitter_sign_in(twitter_user)
    twitter_redirect_back_or user_path(current_user)
    #binding.pry
  end

end
