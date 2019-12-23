class User < ApplicationRecord
  USERNAME_FORMAT = /\A[a-zA-Z0-9]+\z/.freeze
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 20}
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: true },
            length: { minimum: 5, maximum: 15 },
            format: { with: Regexp.new(USERNAME_FORMAT) }

  has_many :search_histories

end
