class EventAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  ROLE_ICONS = {
    'tank' => 'https://cdn.discordapp.com/emojis/866882923063541760.png',
    'dps_melee' => 'https://cdn.discordapp.com/emojis/919741330769449031.png',
    'healer' => 'https://cdn.discordapp.com/emojis/866882937407668244.png',
    'mago' => 'https://cdn.discordapp.com/emojis/919742467350331392.png',
    'arquero' => 'https://cdn.discordapp.com/emojis/919741952239497236.png?size=240'
  }

  scope :coming,     -> { where(will_come: true) }
  scope :not_coming, -> { where(will_come: false) }

  # dont uncomment: this is now validated by a uniqueness index at db lvl
  # validates :discord_id, presence: true, uniqueness: { scope: :event_id }

  def self.get_guild(roles)
    return "Lokthar" if "Lokthar".in?(roles)
    return "Drakkarys" if "Drakkarys".in?(roles)
    return "GodComplex" if "GodComplex".in?(roles)
    return "Legion" if "Legion".in?(roles)
    "NN"
  end

  def roles_human
    [role_1, role_2, role_3].compact.map(&:humanize).join(", ")
  end

  def role_icon
    img_1 = "<img src='#{ROLE_ICONS[role_1]}' width='30' style='display: inline;' alt=#{role_1.humanize}>" if role_1
    img_2 = "<img src='#{ROLE_ICONS[role_2]}' width='30' style='display: inline;' alt=#{role_2.humanize}>" if role_2
    img_3 = "<img src='#{ROLE_ICONS[role_3]}' width='30' style='display: inline;' alt=#{role_3.humanize}>" if role_3
    [img_1, img_2, img_3].compact.join(" ")
  end
end
