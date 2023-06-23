class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.string :name
      t.string :assigned_to
      t.string :managed_by

      t.timestamps
    end
  end
end
