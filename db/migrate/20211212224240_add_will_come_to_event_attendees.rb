class AddWillComeToEventAttendees < ActiveRecord::Migration[7.0]
  def change
    add_column :event_attendees, :will_come, :boolean, default: true
    add_column :event_attendees, :reason, :string
  end
end
