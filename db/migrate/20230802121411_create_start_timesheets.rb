class CreateStartTimesheets < ActiveRecord::Migration[6.0]
  def change
    create_table :start_timesheets do |t|
      t.date :date
      t.time :start_time
      t.string :task_detail
      t.string :time_limit
      t.string :staff_id, null: false, foreign_key: true

      # Add any other specific attributes for StartTimesheet

      t.timestamps
    end
  end
end
