class AddGuildAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :guild_admin, :boolean, default: false
  end
end
