class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.date :birthday
      t.integer :sex
      t.monetize :fixed_price, default: 0, null: false

      t.string :phone
      t.string :cell_phone
      t.string :email
      
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code

      t.jsonb :grouped_appointments, default: {}

      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
