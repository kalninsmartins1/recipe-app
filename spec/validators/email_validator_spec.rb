require 'rails_helper'

RSpec.describe EmailFormatValidator do
  it 'should accept valid email' do
    expect(EmailFormatValidator.valid?('janis123@inbox.lv')).to eq(true)
    expect(EmailFormatValidator.valid?('janis@inbox.lv')).to eq(true)
    expect(EmailFormatValidator.valid?('peteris@gmeils.com')).to eq(true)
  end

  it 'should reject invalid email' do
    expect(EmailFormatValidator.valid?('janis123@inboxlv')).to eq(false)
    expect(EmailFormatValidator.valid?('janis123inboxlv')).to eq(false)
    expect(EmailFormatValidator.valid?('@janis123inbox.lv')).to eq(false)
  end
end
