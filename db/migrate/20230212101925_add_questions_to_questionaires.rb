class AddQuestionsToQuestionaires < ActiveRecord::Migration[7.0]
  def change
    add_column :distributor_questionaires, :length, :number
    add_column :distributor_questionaires, :yearly_amount, :number
    add_column :distributor_questionaires, :other_products, :string
    add_column :distributor_questionaires, :pays_deposit, :boolean
    add_column :distributor_questionaires, :pays_wire, :boolean
    add_column :distributor_questionaires, :pays_card, :boolean
    add_column :distributor_questionaires, :pays_crypto, :boolean
    
    add_column :producer_questionaires, :commodities, :string
    add_column :producer_questionaires, :volume, :number
    add_column :producer_questionaires, :pays_deposit, :boolean
    add_column :producer_questionaires, :pays_wire, :boolean 
    add_column :producer_questionaires, :pays_card, :boolean
    add_column :producer_questionaires, :pays_crypto, :boolean
  end
end
