require 'launchy'

class TwitterSessionsController < ApplicationController
  
  def new
    #binding.pry
    @twitter_user = client.user if twitter_signed_in?
  end
  
  def create
      #binding.pry
      request_token = oauth_consumer.get_request_token(:oauth_callback => callback_url)
      session['twitter_request_token'] = request_token.token
      session['twitter_request_secret'] = request_token.secret
      #Redirects to the url where the user will grant or denny acces to their data
      #url = request_token.authorize_url
      url = "https://api.twitter.com/oauth/authenticate?oauth_token=" + request_token.token + "&force_login=true"
      redirect_to url      
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  def callback   
    begin
      request_token = OAuth::RequestToken.new(oauth_consumer, session['twitter_request_token'], session['twitter_request_secret'])
      access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    
      #binding.pry
      current_user.twitter_access_token = access_token.token
      current_user.twitter_access_secret = access_token.secret
      current_user.save
      #current_user.update_attribute(:access_token, access_token.token)
      #current_user.update_attribute(:access_secret, access_token.secret)
    
      reset_session
      session['twitter_access_token'] = access_token.token
      session['twitter_access_secret'] = access_token.secret
    
      twitter_user = client.verify_credentials
      twitter_sign_in(twitter_user)
      twitter_redirect_back_or user_path(current_user)
      #binding.pry
    rescue OAuth::Unauthorized      
      redirect_to user_path(current_user)
      ir_a_twitter = "Ir a Twitter"
      link = "<a href=\"https://api.twitter.com/home\" target=\"_blank\" >#{ir_a_twitter}</a>"
      flash[:error] = "Usted no esta sincronizado con Twitter!. Cuidado! Su cuenta de Twitter ha sido abierta. Si desea ir a Twitter presione el siguiente link #{link}".html_safe
      #Launchy.open("https://api.twitter.com/home")  
    end
  end

end
