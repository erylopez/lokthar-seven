class EventAttendee < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

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
end
