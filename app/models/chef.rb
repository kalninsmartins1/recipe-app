class Chef < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true,
                   length: {within: 3..20}
  validates :email, presence: true,
                    length: {within: 3..320},
                    email_format: true,
                    uniqueness: {case_sensitive: false}
  validates :password, allow_nil: true,
                       length: {within: 5..16}
end
