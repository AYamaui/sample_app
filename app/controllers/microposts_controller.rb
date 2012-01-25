class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    binding.pry
    if @micropost.save
      flash[:success] = "Micropost created!"
      
      #Se envia un twitter con el contenido del micropost
      @twitter_user = client.user if twitter_signed_in?
      unless @twitter_user.nil? 
        Twitter.update(params[:micropost]['content'])
      end
      
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  
  private
    def authorized_user
      @micropost = current_user.microposts.find(params[:id])
    rescue
      redirect_to root_path
    end 
end
