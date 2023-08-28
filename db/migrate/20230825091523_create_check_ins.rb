class CreateCheckIns < ActiveRecord::Migration[6.0]
  def change
    create_table :check_ins do |t|
      t.references :staff, null: false, foreign_key: true
      t.datetime :check_in_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :check_out_at

      t.timestamps
    end
  end
end
