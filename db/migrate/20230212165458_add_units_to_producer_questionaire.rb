class AddUnitsToProducerQuestionaire < ActiveRecord::Migration[7.0]
  def change
    add_column :producer_questionaires, :unit, :string
  end
end
