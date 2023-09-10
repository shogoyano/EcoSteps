class Like < ApplicationRecord
  belongs_to :active
  belongs_to :user

  validates_uniqueness_of :active_id, scope: :user_id
end
