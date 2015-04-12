class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
    if user_signed_in? && current_user.user_type == "renter"
      redirect_to renter_dashboard_path
    elsif user_signed_in? && current_user.user_type == "owner"
      redirect_to owner_dashboard_path
    end
  end

  def renter
    if user_signed_in? && current_user.user_type == "renter"
      redirect_to '/renter/dashboard'
    elsif user_signed_in? && current_user.user_type == "owner"
      redirect_to owner_dashboard_path
    end
  end

  # Owners Actions
  def owner
    if user_signed_in? && current_user.user_type == "renter"
        redirect_to '/renter/dashboard'
    end

    if user_signed_in? && current_user.user_type == "owner"
        redirect_to '/owner/dashboard'
    end

  end

  def owner_main
    if user_signed_in? && current_user.user_type == "owner"

    else
      redirect_to root_path
    end
  end


  def owner_properties

  end


  def owner_renters

  end
  #END
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :user_type
    end
end
