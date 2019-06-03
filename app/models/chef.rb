class Chef < ApplicationRecord
  has_many :recipes
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates :email, presence: true,
                    length: {minimum: 3, maximum: 320},
                    email_format: true,
                    uniqueness: {case_sensitive: false}
end
