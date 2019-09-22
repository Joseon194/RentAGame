class User < ApplicationRecord
  include BCrypt
  has_many :games
  has_many :reviews
  has_many :reviewed_games, through: :reviews, source: :game
  has_secure_password
  validates :name, :password, presence: true
  validates :email, uniqueness: true

def self.generic_password
  @password = BCrypt::Password.create(ENV['GENERIC_PASSWORD'])
end
end
