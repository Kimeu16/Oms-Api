class CreateLeaveForms < ActiveRecord::Migration[7.0]
  def change
    create_table :leave_forms do |t|
      t.integer :staff_id
      t.date :date_from
      t.date :date_to
      t.text :reason_for_leave
      t.string :leave_type

      t.timestamps
    end
  end
end
