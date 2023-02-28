class AddLatestReceivedToNewsletterSubscriber < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletter_subscribers, :latest_received, :integer
  end
end
