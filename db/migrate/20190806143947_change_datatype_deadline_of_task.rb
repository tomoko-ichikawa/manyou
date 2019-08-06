class ChangeDatatypeDeadlineOfTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :datetime, default:-> { 'CURRENT_TIMESTAMP' }
  end
end
