class Event < ApplicationRecord
  ACTIVITIES = ["Defensa 50v50", "Ataque 50v50", "PvP openworld"]
  has_many :event_attendees
  has_many :event_parties
end
