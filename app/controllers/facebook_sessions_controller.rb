class FacebookSessionsController < ApplicationController
  def new
  end

  def create
    @oauth = Koala::Facebook::OAuth.new('284569178262995', '145d0bfb9c498bfa90ef226432c666f9', callback_url)
  end

  def destroy
  end

  def callback
  end

end
