class RolesController < ApplicationController
  # before_action :is_super_admin?, except: [:show]
  before_action :set_role, only: %i[show edit update destroy]
  load_and_authorize_resource

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
    @permissions = Permission.all
    # @permissions_by_subject_class = Permission.all.group_by(&:subject_class)
  end

  def show
    @permissions = @role.permissions
  end

  def edit
    @permissions = Permission.all
    @role_permissions = @role.permissions.pluck(:id)
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: 'Role was successfully created.'
    else
      @permissions = Permission.all
      render :new
    end
  end

  def update
    @role.permissions = []
    @role.set_permissions(params[:permissions]) if params[:permissions]
    if @role.save
      redirect_to roles_path,  notice: 'Role was successfully updated.'
    else
      @permissions = Permission.all
      render 'edit'
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, notice: 'Role was successfully deleted.'
  end

  private

  # def is_super_admin?
  #   redirect_to root_path unless current_user.roles.any? { |role| role.name == 'Super Admin' }
  # end

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, permission_ids: [])
  end
end
