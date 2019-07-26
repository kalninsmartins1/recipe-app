class Chef < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_secure_password
  before_save { self.email = email.downcase }

  validates_presence_of :name
  validates_length_of :name, within: 3..20

  validates_presence_of :email
  validates_length_of :email, within: 3..320
  validates :email, email_format: true
  validates_uniqueness_of :email, case_sensitive: false

  validates_length_of :password, within: 5..16, allow_nil: true
end
