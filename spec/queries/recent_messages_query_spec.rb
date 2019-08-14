require 'rails_helper'

RSpec.describe RecentMessagesQuery do
  before(:each) do
    @chef = Chef.create(name: 'Peter', email: 'peter12@test.com', password: 'password')
  end

  it 'class method most_recent returns last 20 messages' do
    excluded_message = @chef.messages.create(content: 'Excluded !', created_at: 1.day.ago)
    20.times do |i|
      @chef.messages.create(content: "This is a message #{i}")
    end

    most_recent_messages = RecentMessagesQuery.messages
    expect(most_recent_messages.include?(excluded_message)).to eq(false)
    expect(most_recent_messages.count).to eq(20)
  end
end
