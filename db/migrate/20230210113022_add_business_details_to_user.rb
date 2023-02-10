class AddBusinessDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :company_address, :string
    add_column :users, :tax_identification_number, :number
  end
end
