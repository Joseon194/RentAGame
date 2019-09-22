class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :name, :genre, :company, presence: true
end
