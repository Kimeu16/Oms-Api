class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :client_name
      t.text :description
      t.integer :client_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
