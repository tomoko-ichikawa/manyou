class Task < ApplicationRecord
  validates :task_name, :content, presence: true
  enum priority: { 未着手: 0, 高: 1, 中: 2, 低: 3 }
end
