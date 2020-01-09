class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :users, through: :reviews
  validates :name, :genre, :company, :platform, presence: true
  
  def self.most_recent(number)
    Game.all.order("created_at DESC").take(number)
  end
end
