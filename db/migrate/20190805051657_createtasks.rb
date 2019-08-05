class Createtasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :label_id
      t.string :task_name
      t.datetime :deadline
      t.integer :priority
      t.string :status
      t.text :content
      t.timestamps
    end
  end
end
