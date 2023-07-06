class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.text :description
      t.string :client_details
      t.integer :client_id, null: true, foreign_key: true

      t.timestamps
    end
  end
end
