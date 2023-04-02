class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :email_reset_token, :password_reset_token
  end
end
