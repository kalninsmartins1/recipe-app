require 'rails_helper'

RSpec.describe EmailFormatValidator do
  it 'should accept valid email' do
    expect(EmailFormatValidator.valid?('john123@test.com')).to eq(true)
    expect(EmailFormatValidator.valid?('janis@inbox.com')).to eq(true)
    expect(EmailFormatValidator.valid?('peteris@gmeils.com')).to eq(true)
  end

  it 'should reject invalid email' do
    expect(EmailFormatValidator.valid?('janis123@inboxlv')).to eq(false)
    expect(EmailFormatValidator.valid?('janis123inboxlv')).to eq(false)
    expect(EmailFormatValidator.valid?('@janis123inbox.com')).to eq(false)
  end
end
