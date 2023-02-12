class AddQuestionsToQuestionaires < ActiveRecord::Migration[7.0]
  def change
    add_column :distributor_questionare, :length, :number
    add_column :distributor_questionare, :yearly_amount, :number
    add_column :distributor_questionare, :other_products, :string
    add_column :distributor_questionare, :pays_deposit, :boolean
    add_column :distributor_questionare, :pays_wire, :boolean
    add_column :distributor_questionare, :pays_card, :boolean
    add_column :distributor_questionare, :pays_crypto, :boolean
    
    add_column :producer_questionare, :commodities, :string
    add_column :producer_questionare, :volume, :number
    add_column :producer_questionare, :pays_deposit, :boolean
    add_column :producer_questionare, :pays_wire, :boolean 
    add_column :producer_questionare, :pays_card, :boolean
    add_column :producer_questionare, :pays_crypto, :boolean
  end
end
