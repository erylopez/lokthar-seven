class AddNicknameToEventAttendees < ActiveRecord::Migration[7.0]
  def change
    add_column :event_attendees, :nickname, :string
  end
end
