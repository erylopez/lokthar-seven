class CreateDiscordSetups < ActiveRecord::Migration[7.0]
  def change
    create_table :discord_setups do |t|
      t.string :created_by
      t.string :server_id
      t.string :channel_id
      t.string :server_name
      t.string :channel_name
      t.string :role_tag

      t.timestamps
    end
  end
end
