class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :client_name
      t.text :description
      t.string :main_email
      t.string :second_email
      t.string :first_contact
      t.string :second_contact

      t.timestamps
    end
  end
end
