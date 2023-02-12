class QuestionairesBelongToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :producer_questionaires, :user, null: false, foreign_key: true
    add_reference :distributor_questionaires, :user, null: false, foreign_key: true
  end
end
