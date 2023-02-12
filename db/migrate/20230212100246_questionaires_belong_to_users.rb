class QuestionairesBelongToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :producer_questionaires, :user
    add_foreign_key :producer_questionaires, :user

    add_reference :distributor_questionaires, :user
    add_foreign_key :distributor_questionaires, :user
  end
end
