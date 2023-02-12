class CreateProducerQuestionaires < ActiveRecord::Migration[7.0]
  def change
    create_table :producer_questionaires do |t|

      t.timestamps
    end
  end
end
