class MethodLike < ApplicationRecord
  validates :user_id, {presence: true}
  validates :methodpost_id, {presence: true}
end
