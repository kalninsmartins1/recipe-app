class Chef < ApplicationRecord
  has_many :recipes
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {within: 3..20}
  validates :email, presence: true,
                    length: {within: 3..320},
                    email_format: true,
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {within: 5..16}
end
