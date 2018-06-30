class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status, index: true, default: 0
      t.json :info
      t.datetime :deleted_at
      
      t.timestamps null: false
    end
  end
end
