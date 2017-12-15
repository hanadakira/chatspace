class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.order('id DESC')
    @message = Message.new
    @group = Group.find(params[:group_id])
    @messages = Message.includes(:group).order("created_at DESC")
  end

  def create
    @message = Message.new(message_params.merge(user_id: current_user.id,group_id: params[:group_id]))
    if @message.save
      redirect_to({action: :index, group_id:params[:group_id]},notice: 'メッセージが送信されました。')
    else
      redirect_to :root, alert: 'メッセージが送信できませんでした。'
    end
  end

  def message_params
    params.require(:message).permit(:body,:image)
  end

end
