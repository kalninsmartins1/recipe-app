# Request controller for showing chat room
class ChatRoomsController < ApplicationController
  before_action :require_chef, only: [:show]

  def show
    @message = Message.new
    @messages = RecentMessagesQuery.messages
  end
end
