# Request controller for creating new messages within chatroom
class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.chef_id = current_chef.id
    if message.save
      flash[:sucess] = 'Message sucessfully sent !'
      redirect_to chat_path
    else
      redirect_back(fallback_location: chat_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
