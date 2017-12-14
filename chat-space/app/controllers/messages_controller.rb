class MessagesController < ApplicationController
  def index
    @groups = current_user.groups.order('id DESC')
    @message = Message.new
    @group = Group.find(16)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to :root,notice: 'メッセージが送信されました。'
    else
      redirect_to :root, alert: 'メッセージが送信できませんでした。'
    end
  end

  def message_params
    params.permit(:body,:image,:user_id,:group_id)
  end

end
