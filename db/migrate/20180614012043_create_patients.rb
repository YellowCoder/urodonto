class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.boolean :active
      t.boolean :temporary

      t.string :name, null: false
      t.string :birthday
      t.string :sex

      t.string :phone
      t.string :cell_phone
      t.string :email
      
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps null: false
    end
  end
end
