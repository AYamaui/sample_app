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
      
      #Parte de twitter------------
      
      client = TwitterOAuth::Client.new(
          :consumer_key => '8HMEWgi9jCjSS8DzWyX8Q',
          :consumer_secret => 'N96T1OPRx5vQgCIzoKVMKntXcALkckNmt4mCwaKioGA'
      )

      request_token = client.request_token(:oauth_callback => oauth_confirm_url)
      #@access_token = @request_token.get_access_token(:oauth_verifier =>
      #params[:oauth_verifier])
      binding.pry
      #:oauth_callback required for web apps, since oauth gem by default force PIN-based flow
      #( see http://groups.google.com/group/twitter-development-talk/browse_thread/thread/472500cfe9e7cdb9/848f834227d3e64d )

      #request_token.authorize_url => http://twitter.com/oauth/authorize?oauth_token=TOKEN
      #Link this url to in your view file, so that user will be redirected to the Twitter authentication page.
      
      #Termina parte de twitter--------
      
      
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
