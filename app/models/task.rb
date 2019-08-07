class Task < ApplicationRecord
  validates :task_name, :content, presence: true

  scope :important, -> {order(priority: :asc)}
  scope :latest, -> {order(created_at: :desc)}
  scope :expired, -> {order(deadline: :asc)}
  scope :search_task_name, ->(task_name){where("task_name like?", "%#{task_name}%")}
  scope :search_status, ->(status){where("status like?", "%#{status}%")}

  enum priority: { 未着手: 0, 高: 1, 中: 2, 低: 3 }
end
