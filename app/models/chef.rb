class Chef < ApplicationRecord
  has_many :recipes
  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates :email, presence: true,
                    length: {minimum: 3, maximum: 320},
                    format: {with: URI::MailTo::EMAIL_REGEXP},
                    uniqueness: {case_sensitive: false}
end
