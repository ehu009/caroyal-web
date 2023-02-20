class CreateTimelineEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :timeline_events do |t|
      t.datetime :time
      t.string :title
      t.text :text
      t.integer :number

      t.timestamps
    end
  end
end
