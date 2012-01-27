class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
     if user.nil?
       flash.now[:error] = "Invalid email/password combination"
       @title = "Sign in"
       render 'new'
     else       
       #binding.pry
       sign_in user
       @twitter_user = client.user if twitter_signed_in?
       if !current_user.access_token.nil?
         create_twitter_connection
       end
       redirect_back_or user
     end
  end

  def destroy
    #Twitter reset session
    reset_session
    unless current_user.access_token.nil?
      Twitter.end_session
    end
    sign_out
    redirect_to root_path
  end
  
  def create_twitter_connection
    #binding.pry
    twitter_user = client.verify_credentials
    twitter_sign_in(twitter_user)
  end

end
