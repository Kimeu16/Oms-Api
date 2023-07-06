class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.date :your_name
      t.date :date_from
      t.date :date_to
      t.text :reason_for_leave
      t.string :leaving_type
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
