class Chef < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_secure_password
  before_save { self.email = email.downcase if email }

  validates :name, presence: true
  validates :name, length: {within: 3..20}

  validates :email, presence: true
  validates :email, length: {within: 3..320}
  validates :email, email_format: true
  validates :email, uniqueness: {case_sensitive: false}

  validates :password, length: {within: 5..16}, allow_nil: true
end
