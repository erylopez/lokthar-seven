class DiscordSetup < ApplicationRecord
  def channel_tag
    "#{channel_name}@#{server_name}"
  end
end
