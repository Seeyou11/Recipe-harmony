class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy ]
  # before_action :is_super_admin?, except: [:show]
  load_and_authorize_resource

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
  
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def assign_roles
    @user = User.find(params[:id])
    @roles = Role.all
  end


  def update_roles
    @user = User.find(params[:id])
    role_ids = params[:user][:role_ids].reject(&:blank?)

    # if current_user.super_admin?
      @user.roles = Role.where(id: role_ids)
      redirect_to users_path, notice: "Roles successfully updated."
    # else
    #   redirect_to root_path, alert: "You do not have permission to perform this action."
    # end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def is_super_admin?
    redirect_to root_path unless current_user.roles.any? { |role| role.name == 'Super Admin' }
  end
  
end
