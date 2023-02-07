class AddDistributorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :distributor, :boolean
  end
end
