class AddRoleColumn < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :status, :boolean
  end
end
