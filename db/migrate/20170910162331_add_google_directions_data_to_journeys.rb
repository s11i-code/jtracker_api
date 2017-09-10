class AddGoogleDirectionsDataToJourneys < ActiveRecord::Migration[5.1]
  def change
    add_column :journeys, :google_directions_data, :jsonb
  end
end
