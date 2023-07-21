class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :bio
      t.string :avatar
      t.string :about
      t.string :location
      t.integer :staff_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
