class QuestionairesBelongToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :producer_questionares, :user
    add_foreign_key :producer_questionares, :user

    add_reference :distributor_questionares, :user
    add_foreign_key :distributor_questionares, :user
  end
end
