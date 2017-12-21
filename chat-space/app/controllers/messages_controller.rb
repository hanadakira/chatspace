class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.order('id DESC')
    @message = Message.new
    @group = Group.find(params[:group_id])
    @messages = Message.includes(:group).order("created_at DESC")
  end

  def create
    # binding.pry
    @group = Group.find(params[:group_id])
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
  def message_params
    params.require(:message).permit(:body,:image).merge(user_id: current_user.id,group_id: params[:group_id])
  end

end
