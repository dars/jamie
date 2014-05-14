class AddColumnLicenseId < ActiveRecord::Migration
  def change
    add_column :users, :license_id, :string
  end
end
