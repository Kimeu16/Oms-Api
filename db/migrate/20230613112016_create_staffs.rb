class CreateStaffs < ActiveRecord::Migration[7.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.date :joining_date
      t.string :reporting_to
      t.text :tech_stack

      t.timestamps
    end
  end
end
