class MethodLike < ApplicationRecord
  belongs_to :user
  belongs_to :methodpost

  validates :user_id, { presence: true }
  validates :methodpost_id, { presence: true }
end
