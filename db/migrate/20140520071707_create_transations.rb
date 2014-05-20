class CreateTransations < ActiveRecord::Migration
  def change
    create_table :transations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :type
      t.integer :device_id

      t.timestamps
    end
  end
end
