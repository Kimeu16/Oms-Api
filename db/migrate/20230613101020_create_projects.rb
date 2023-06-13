class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :client_name
      t.text :description
      t.string :action

      t.timestamps
    end
  end
end
