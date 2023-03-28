class AddPasswordResetToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_reset_token, :integer
    add_column :users, :email_reset_token, :string
    add_column :users, :reset_token_sent_at, :datetime
  end
end
