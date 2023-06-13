class CreateTimesheets < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheets do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.integer :task_id
      t.text :progress_details
      t.string :action

      t.timestamps
    end
  end
end
