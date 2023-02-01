class AddTimeRecordedToPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :time_recorded, :datetime
  end
end
