class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :patient, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :chargeable, default: true
      t.integer :status, index: true, default: 0
      t.string :title
      t.string :color
      t.text :observations
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.datetime :payment_due, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end