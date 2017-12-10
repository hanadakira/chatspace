class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id]) if user.id == current_user.id
  end

  def update
    user =User.find(params[:id])
      user.update(user_params)
    end
  end

Private
def user_params
  params.permit(:name,:email)
end
