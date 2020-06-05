class Comment < ApplicationRecord
  belongs_to :course
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
