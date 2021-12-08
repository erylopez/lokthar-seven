class AddDiscordMessagesToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :discord_messages, :jsonb
  end
end
