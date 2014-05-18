class AddDealerId < ActiveRecord::Migration
  def change
    add_reference :Device, :dealer
  end
end
