class AddCompanyCityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :company_city, :string
  end
end
