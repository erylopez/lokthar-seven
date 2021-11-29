class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :activity
      t.string :name
      t.datetime :starts_at
      t.integer :tanks_needed
      t.integer :healers_needed
      t.integer :melee_dps_needed
      t.integer :ranged_dps_needed
      t.integer :mages_needed
      t.string :event_details
      t.string :event_image_url

      t.timestamps
    end
  end
end
