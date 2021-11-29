class CreateEventAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :event_attendees do |t|
      t.string :discord_id
      t.string :name
      t.string :discriminator
      t.string :from_server
      t.string :from_channel
      t.string :guild
      t.string :role_1
      t.string :role_2
      t.string :role_3
      t.references :event, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
