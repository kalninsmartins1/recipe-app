# Class for fetching recent messages
class RecentMessagesQuery
  def self.messages
    Message.all.order(:created_at).last(20)
  end
end
