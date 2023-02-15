class AddCompanyCountryToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :company_country, :string
  end
end
