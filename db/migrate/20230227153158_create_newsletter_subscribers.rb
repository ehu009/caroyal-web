class CreateNewsletterSubscribers < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletter_subscribers do |t|
      t.string :email
      t.string :unsubscribe_token

      t.timestamps
    end
  end
end
