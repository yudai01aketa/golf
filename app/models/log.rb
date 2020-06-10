class Log < ApplicationRecord
  belongs_to :course
  default_scope -> { order(created_at: :desc) }
  validates :course_id, presence: true
end
