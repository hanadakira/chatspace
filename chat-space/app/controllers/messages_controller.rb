class MessagesController < ApplicationController

  def index
    @groups = current_user.groups.order('id DESC')
    @message = Message.new
    @group = Group.find(params[:group_id])
    @messages = Message.includes(:group).order("created_at ASC")
  end

  def create
    # binding.pry
    @group = Group.find(params[:group_id])
    @message = Message.create(message_params)
    respond_to do |format|
      format.html { redirect_to group_messages_path(@group) }
      format.json
    end
  end

  private
  def message_params
    params.require(:message).permit(:body,:image).merge(user_id: current_user.id,group_id: params[:group_id])
  end

end
