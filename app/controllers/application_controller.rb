class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def authenticate_admin_reg_desk!
    if admin_signed_in? || reg_desk_signed_in?
        true
    else
        authenticate_reg_desk!
    end
  end

  def authenticate_admin_coordinator!
    if admin_signed_in? || coordinator_signed_in?
        true
    else
        authenticate_coordinator!
    end
  end

	def configure_permitted_parameters
  		devise_parameter_sanitizer.for(:sign_up) do |u| 
  			u.permit(:name, :rollnumber, :email, :password, :password_confirmation,:event_id) 
  		end
	end

  def after_sign_in_path_for(coordinator)
    sign_in_url = new_coordinator_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(coordinator) || request.referer || attendances_path
    end
  end

  def after_sign_in_path_for(reg_desk)
    sign_in_url = new_reg_desk_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(reg_desk) || request.referer || participants_path
    end
  end

    def after_sign_in_path_for(admin)
    sign_in_url = new_admin_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(admin) || request.referer || events_path
    end
  end


end

