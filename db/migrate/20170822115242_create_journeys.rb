class CreateJourneys < ActiveRecord::Migration[5.1]
  def change
    create_table :journeys do |t|
      t.integer :origin_id
      t.integer :destination_id
      t.datetime :end_time
      t.timestamps
    end
  end
end
