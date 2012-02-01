class FacebookSessionsController < ApplicationController
  def new
  end

  def create
    @fb_oauth_consumer ||= OAuth::Consumer.new('8HMEWgi9jCjSS8DzWyX8Q', 'N96T1OPRx5vQgCIzoKVMKntXcALkckNmt4mCwaKioGA', :site => 'http://api.twitter.com', :request_endpoint => 'http://api.twitter.com', :sign_in => false)  
    @oauth = Koala::Facebook::OAuth.new('284569178262995', '145d0bfb9c498bfa90ef226432c666f9', callback_url)
    @oauth.url_for_oauth_code
  end

  def destroy
  end

  def callback
    request_token = OAuth::RequestToken.new(@oauth, session['fb_request_token'], session['fb_request_secret'])
    @oauth.get_access_token(code)
    redirect_to user_path(current_user)
  end

end
