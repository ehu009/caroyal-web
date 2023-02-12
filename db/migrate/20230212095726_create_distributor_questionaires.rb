class CreateDistributorQuestionaires < ActiveRecord::Migration[7.0]
  def change
    create_table :distributor_questionaires do |t|

      t.timestamps
    end
  end
end
