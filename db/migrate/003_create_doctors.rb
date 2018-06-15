class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.boolean :active
      t.string :name, null: false
      
      t.timestamps null: false
    end
  end
end