class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :doctor, null: false, index: true, foreign_key: true
      t.references :patient, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.string :title
      t.string :type
      t.string :status
      t.string :color

      t.timestamps null: false
    end
  end
end
