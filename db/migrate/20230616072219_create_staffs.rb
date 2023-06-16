class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.date :joining_date
      t.string :reporting_to
      t.string :email
      t.string :password_digest
      t.text :tech_stack
      t.boolean :isadmin, default: false
      t.integer :admin_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
