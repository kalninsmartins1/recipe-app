# Request controller for showing chat room
class ChatroomsController < ApplicationController
  def show
    @message = Message.new
    @messages = Message.all
  end
end
