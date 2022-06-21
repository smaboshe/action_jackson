class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user
      sign_in(user)
    else
      render :new
    end
  end

  def destroy
    sign_out if signed_in?
    flash[:notice] = t("sessions.flash.sign_out")
    redirect_to root_path
  end
end
