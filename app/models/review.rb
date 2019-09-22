class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :content, presence: true

  def user_attributes=(user_attributes)
    user = User.find_by(name: user_attributes[:name])
    if !user
      user = User.create(name: user_attributes[:name]), passsword
end
self.user = user
end
end
