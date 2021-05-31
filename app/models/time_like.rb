class TimeLike < ApplicationRecord
  belongs_to :user
  belongs_to :timepost

  validates :user_id, { presence: true }
  validates :timepost_id, { presence: true }
end
