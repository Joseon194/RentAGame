class User < ApplicationRecord
  include BCrypt
  has_many :games
  has_many :reviews
  has_many :reviewed_games, -> { distinct }, through: :reviews, source: :game, dependent: :destroy
  has_secure_password
  validates :name, :password, presence: true
  validates :email, uniqueness: true

def self.generic_password
  @password = BCrypt::Password.create(ENV['GENERIC_PASSWORD'])
end

def self.from_omniauth(auth)
  # Creates a new user only if it doesn't exist
  where(email: auth.info.email).first_or_initialize do |user|
    user.name = auth.info.name
    user.email = auth.info.email
  end
end
end
