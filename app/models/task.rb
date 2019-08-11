class Task < ApplicationRecord
  validates :task_name, :content, presence: true

  scope :important, -> {order(priority: :asc)}
  scope :latest, -> {order(created_at: :desc)}
  scope :expired, -> {order(deadline: :asc)}

  scope :search, -> (params) {where('(task_name LIKE ?) AND (status LIKE ?)', "%#{params[:task][:task_name_key]}%", "%#{params[:task][:status_key]}%")}


  enum priority: { 高: 0, 中: 1, 低: 2 }
end
