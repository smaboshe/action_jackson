class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to "/sign_in" unless @current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
  end
end
