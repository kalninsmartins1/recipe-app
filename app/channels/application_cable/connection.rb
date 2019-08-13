module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_chef

    def connect
      self.current_chef = find_current_chef
    end

    def disconnect; end

    private

    def find_current_chef
      current_chef = ValidChefDecorator.find_by(id: cookies.signed[:chef_id])
      if current_chef.id != -1
        current_chef
      else
        reject_unauthorized_connection
      end
    end
  end
end
