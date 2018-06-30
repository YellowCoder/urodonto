class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, index: true, foreign_key: true
      t.references :patient, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :status, index: true, default: 0
      t.string :title
      t.string :color
      t.text :observations
      t.datetime :start
      t.datetime :end

      t.timestamps null: false
    end
  end
end
