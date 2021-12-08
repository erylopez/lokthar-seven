class AddUniqueIndexToEventAttendees < ActiveRecord::Migration[7.0]
  def change
    add_index :event_attendees, [:discord_id, :event_id], :unique => true
  end
end
