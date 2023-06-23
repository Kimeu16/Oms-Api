class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.date :date_from
      t.date :date_to
      t.text :reason_for_leave
      t.string :leave_type
      t.integer :staff_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
