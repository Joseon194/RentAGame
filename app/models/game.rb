class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :name, :genre, :company, :platform, presence: true
end
