class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      
=begin
      #Parte de twitter------------
      
      consumer_key = '8HMEWgi9jCjSS8DzWyX8Q'
      consumer_secret = 'N96T1OPRx5vQgCIzoKVMKntXcALkckNmt4mCwaKioGA'
      
      client = TwitterOAuth::Client.new(
          :consumer_key => consumer_key,
          :consumer_secret => consumer_secret
      )
      
      request_token = client.get_request_token(:oauth_callback => oauth_confirm_url)
      request_secret = request_token.secret
      
      puts request_token.token, request_secret
      
      resquest_token_aux = OAuth::RequestToken.new(client, request_token, request_secret)
      acces_token = request_token.get_acces_token
      
      puts access_token.get('/statuses/friends_timeline.json')
      
      access_token = OAuth::AccesToken.new(consumer,'acces token', 'access secret')
      puts acces_token.get('/statuses/friends_timeline.json')
      
      Twitter::Base.new('access token', 'access secret')
      
      redirect_to(request_token.authorize_url)
      #@access_token = @request_token.get_access_token(:oauth_verifier =>
      #params[:oauth_verifier])
      #:oauth_callback required for web apps, since oauth gem by default force PIN-based flow
      #( see http://groups.google.com/group/twitter-development-talk/browse_thread/thread/472500cfe9e7cdb9/848f834227d3e64d )

      #request_token.authorize_url => http://twitter.com/oauth/authorize?oauth_token=TOKEN
      #Link this url to in your view file, so that user will be redirected to the Twitter authentication page.
      
      #Termina parte de twitter--------
      
=end
      
      
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  
  private
      def authenticate
        deny_access unless signed_in?
      end
      
      def correct_user
         @user = User.find(params[:id])
         redirect_to(root_path) unless current_user?(@user)
      end
      
      def admin_user
         redirect_to(root_path) unless current_user.admin?
      end
  
end
