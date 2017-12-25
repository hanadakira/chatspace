class MessagesController < ApplicationController

before_action :set_group, only: [:index,:new,:create]

  def index
    @groups = current_user.groups.order('id DESC')
    @message = Message.new
    @messages = @group.messages.includes(:user)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group) }
        format.json
      end
    else
      render:index
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end
  def message_params
    params.require(:message).permit(:body,:image,:group_id,:image).merge(user_id: current_user.id,group_id: params[:group_id])
  end

end
