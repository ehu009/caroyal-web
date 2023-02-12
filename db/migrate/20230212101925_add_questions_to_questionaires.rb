class AddQuestionsToQuestionaires < ActiveRecord::Migration[7.0]
  def change
    add_column :distributor_questionaire, :length, :number
    add_column :distributor_questionaire, :yearly_amount, :number
    add_column :distributor_questionaire, :other_products, :string
    add_column :distributor_questionaire, :pays_deposit, :boolean
    add_column :distributor_questionaire, :pays_wire, :boolean
    add_column :distributor_questionaire, :pays_card, :boolean
    add_column :distributor_questionaire, :pays_crypto, :boolean
    
    add_column :producer_questionaire, :commodities, :string
    add_column :producer_questionaire, :volume, :number
    add_column :producer_questionaire, :pays_deposit, :boolean
    add_column :producer_questionaire, :pays_wire, :boolean 
    add_column :producer_questionaire, :pays_card, :boolean
    add_column :producer_questionaire, :pays_crypto, :boolean
  end
end
