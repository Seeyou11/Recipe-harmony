class FollowsController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow, :cancel_request]
  before_action :set_follow_req, only: [:accept_follow, :decline_follow]
  
  # def follow
  #   current_user.follow(@user)
  #   # redirect the user back to the previous page. If there is no previous page available, it falls back to redirecting to the root path.
  #   redirect_back(fallback_location: root_path)
  # end


  def unfollow
    current_user.unfollow(@user)
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("user#{params[:id]}follows")
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def follow
    current_user.follow(@user)
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("user#{params[:id]}follows") do |s|
          s.html { render partial: 'follow_button', locals: { user: @user } }
        end
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end


  def cancel_request
    current_user.cancel_request(@user)
    redirect_back(fallback_location: root_path)
  end

  # def unfollow
  #   current_user.unfollow(@user)
  #   redirect_back(fallback_location: root_path)
  # end


  def accept_follow
    @follow_req.accept
    redirect_back(fallback_location: root_path)
  end

  def decline_follow
    @follow_req.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_follow_req
    @follow_req = Follow.find(params[:follow_id])
  end

end