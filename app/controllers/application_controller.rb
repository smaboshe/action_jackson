class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
    flash[:notice] = "#{t("sessions.flash.sign_in")} #{user.username}"
    redirect_to root_path
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end
end
