class CreateNewsletterArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletter_articles do |t|
      t.string :title
      t.integer :issue_number
      t.boolean :dispatched

      t.timestamps
    end
  end
end
