# Class for validating email addresses
class EmailFormatValidator < ActiveModel::EachValidator
  def self.valid?(email)
    !(email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i).nil?
  end

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || 'is not a valid email') unless
      EmailFormatValidator.valid?(value)
  end
end
