class CreateTimesheets < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheets do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.text :progress_details
      t.integer :task_id, null: false, foreign_key: true
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
