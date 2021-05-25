class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :timepost

  validates :user_id, presence: true
  validates :timepost_id, presence: true
  validates :text, presence: true, length: { maximum: 100 }

  def user
    return User.find_by(id: self.user_id)
  end
end
