class ChangeStringsToText < ActiveRecord::Migration[7.0]
  def change
    change_column :producer_questionaires, :commodities, :text
    change_column :distributor_questionaires, :other_products, :text
  end
end
