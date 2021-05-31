class Review < ApplicationRecord
  belongs_to :user
  belongs_to :methodpost
  # validates :user_id, presence: true
  # validates :methodpost_id, presence: true

  validates :text, presence: true, length: { maximum: 100 }
  validates :evaluation, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

  def user
    User.find_by(id: user_id)
  end
end
