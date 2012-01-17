module Twitter
  module AuthenticationHelpers
    def self.included(controller)
      controller.class_eval do
        helper_method :signed_in?
        hide_action :signed_in?
      end
    end

    def signed_in?
      !twitter_session[:screen_name].nil?
    end

    protected

    def authenticate
      deny_access unless signed_in?
    end

    def deny_access
      store_location
      render :template => "/twitter_sessions/new", :status => :unauthorized
    end

    def sign_in(user)
      twitter_session[:screen_name] = user.screen_name if user
    end

    def redirect_back_or(default)
      twitter_session[:return_to] ||= params[:return_to]
      if twitter_session[:return_to]
        redirect_to(session[:return_to])
      else
        redirect_to(default)
      end
      twitter_session[:return_to] = nil
    end

    def store_location
      twitter_session[:return_to] = request.request_uri if request.get?
    end
  end
end
