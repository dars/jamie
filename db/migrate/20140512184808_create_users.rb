class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :sign_in_count
      t.datetime :last_sign_in_at
      t.string :last_sign_in_ip
      t.string :role
      t.boolean :status

      t.timestamps
    end
  end
end
