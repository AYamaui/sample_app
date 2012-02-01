require 'net/http'

class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create, :get_bounces]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    #binding.pry
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
    session['current_url'] = request.fullpath
    puts 'BOUNCES'
    url = URI.parse('https://sendgrid.com/api/bounces.get.xml?api_user=app2629184@heroku.com&api_key=bwlc5p0g')
    puts url.host
    get_bounces
  end

  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      #Tell the Mailer to send a welcome Email after save
      Mailer.welcome_email(@user).deliver
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"      
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
  
  def get_bounces
    url = URI.parse('https://sendgrid.com/api/bounces.get.json?api_user=app2629184@heroku.com&api_key=bwlc5p0g')
    http = Net::HTTP.new(url.host, '443')
    http.use_ssl = true
    req = Net::HTTP::Get.new('/api/bounces.get.json?api_user=app2629184@heroku.com&api_key=bwlc5p0g')
    res = http.start do |http| http.request(req) end
    puts res.body
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
