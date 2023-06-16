class CreateLeaveTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_types do |t|
      t.string :name
      t.integer :days_allowed
      t.integer :staff_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
