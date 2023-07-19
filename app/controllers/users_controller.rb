class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy ]

  def index
    @userss = User.all
    if params[:search_query].present?
      @users = User.where("username LIKE ?", "%#{params[:search_query]}%")
    else
      @users = []
    end

    if turbo_frame_request?
      render partial: "layouts/search_results", locals: {users: @users}
    end
  end

  def show
    @recipes = Recipe.all
  end

  # def switch_role
  #   @user = User.find(params[:id])
  #   @user.toggle_role
  #   redirect_to users_path, notice: "Role switched successfully."
  # end

  def switch_role
    @user = User.find(params[:id])
    @user.toggle_role
    # redirect_to users_path, notice: "Role switched successfully." 
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
               "switch#{@user.id}role",
                partial: "users/switch_role", 
                locals: { user: @user })
      end
    # format.html { redirect_to users_path, notice: "Role switched successfully." }
    end
  end
  
    def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
