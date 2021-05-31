class Timepost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :time_likes, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :time, presence: true
  validates :minitus, presence: true
  validates :datetime, presence: true
  validates :subjects, presence: true
  validates :content, length: { maximum: 140 }
end
