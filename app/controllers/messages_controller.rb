# Request controller for creating new messages within chatroom
class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.chef_id = current_chef.id
    if message.save
      ActionCable.server.broadcast('chat_room_channel',
                                   message: render_message(message),
                                   chef: message.chef.name)
    else
      redirect_back(fallback_location: chat_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    render(partial: 'message', locals: {message: message})
  end
end
