class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id]) if user.id == current_user.id
  end

  def update
    user =User.find(params[:id])
    user.update(user_params)
    move_to_index
  end

  private
  def user_params
    params.permit(:name,:email)
  end

  def move_to_index
    redirect_to controller: :messages, action: :index
  end
end
