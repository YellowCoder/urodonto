class CreateFinancialRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_records do |t|
      t.references :doctor, null: false, index: true, foreign_key: true
      t.references :patient, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :appointment, index: true, foreign_key: true
      t.integer :status, default: 0
      t.string :title
      t.monetize :amount
      t.date :date
      t.text :observations
      
      t.timestamps null: false
    end
  end
end
