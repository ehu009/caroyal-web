class AddContactDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name_prefix, :string
    add_column :users, :full_name, :string
    add_column :users, :age, :number
    add_column :users, :phone_number, :integer
    add_column :users, :address, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end
