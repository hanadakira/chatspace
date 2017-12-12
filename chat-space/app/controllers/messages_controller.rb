class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @groups = current_user.groups.all.order('id DESC')
  end
end
