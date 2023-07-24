class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :assigned_to
      t.string :managed_by
      t.string :project_name
      t.integer :project_id, null: true, foreign_key: true
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
