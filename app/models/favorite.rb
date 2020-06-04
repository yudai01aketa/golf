class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :course
  default_scope -> { order(created_at: :desc) }
  validates  :user_id,   presence: true
  validates  :course_id, presence: true
end
