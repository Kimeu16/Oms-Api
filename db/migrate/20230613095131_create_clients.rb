class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :client_name
      t.text :description

      t.timestamps
    end
  end
end
