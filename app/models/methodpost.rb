class Methodpost < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy 
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :subjects, presence: true
end
