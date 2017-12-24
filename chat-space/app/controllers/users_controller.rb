class UsersController < ApplicationController

  def index
    @users = User.where('name LIKE(?)', "%#{params[:keyword]}%").limit(5)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to :root,notice: '登録内容を変更しました。'
    else
      flash[:alert]='登録内容を変更してください'
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end
end
