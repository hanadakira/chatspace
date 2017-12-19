class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.order('id DESC')
    @message = Message.new
    @group = Group.find(params[:group_id])
    @messages = Message.includes(:group).order("created_at DESC")
  end

  def create
    @group = Group.find(params[:group_id])
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group),notice: 'メッセージが送信されました。'
    else
      render :index, alert: 'メッセージが送信できませんでした。'
    end
  end

  private
  def message_params
    params.require(:message).permit(:body,:image).merge(user_id: current_user.id,group_id: params[:group_id])
  end

end
