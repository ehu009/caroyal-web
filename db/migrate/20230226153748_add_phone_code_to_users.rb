class AddPhoneCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_code, :integer
  end
end
