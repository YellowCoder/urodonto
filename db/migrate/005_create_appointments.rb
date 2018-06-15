class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, index: true, foreign_key: true
      t.references :patient, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.date :date
      t.integer :status, status: 0
      t.text :observations

      t.timestamps null: false
    end
  end
end
