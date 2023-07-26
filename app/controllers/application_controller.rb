class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_categories

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number, :full_name, roles: []])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :phone_number, :full_name, :profile_pic, :bio, :private])
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'Access denied. You are not authorized to access the requested page.'
    redirect_to root_path
  end

  private

  def set_categories
    @categories = Category.all
  end

  protected

  def load_permissions
    @current_permissions = current_user.role.permissions.pluck(:subject_class, :action)
  end

end
