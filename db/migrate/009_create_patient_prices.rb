class CreatePatientPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_prices do |t|
      t.references :patient, null: false, index: true, foreign_key: true
      t.date :date, null: false
      t.monetize :price, null: false

      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
