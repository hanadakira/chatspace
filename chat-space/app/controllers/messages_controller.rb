class MessagesController < ApplicationController
  def index
    @groups = current_user.groups.order('id DESC')
  end
end
