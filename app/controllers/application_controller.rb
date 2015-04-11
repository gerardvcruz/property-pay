class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
  end

  def renter
    if user_signed_in? && current_user.user_type == "renter"
      redirect_to '/renter/dashboard'
    end
  end

  def owner
    if user_signed_in? && current_user.user_Type == "renter"
      redirect_to '/owner/dashboard'
    end
  end

  def renter_main
    @properties = UserProperty.where(user_id: current_user.id)
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :user_type
    end
end
