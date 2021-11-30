class EventParty < ApplicationRecord
  belongs_to :event

  ROLE_OPTIONS = [
    ['Tank', 'tank'],
    ['Healer', 'healer'],
    ['DPS Melee', 'dps_melee'],
    ['Arquero', 'arquero'],
    ['Mago', 'mago']
  ]

  DEFAULT_OPTIONS = {
    "p0_m1" => ['Tank', 'tank'],
    "p0_m2" => ['Healer', 'healer'],
    "p0_m3" => ['Healer', 'healer'],
    "p0_m4" => ['DPS melee', 'dps_melee'],
    "p0_m5" => ['Mago', 'mago'],
    "p1_m1" => ['Tank', 'tank'],
    "p1_m2" => ['Healer', 'healer'],
    "p1_m3" => ['Healer', 'healer'],
    "p1_m4" => ['DPS melee', 'dps_melee'],
    "p1_m5" => ['Mago', 'mago'],
    "p2_m1" => ['Tank', 'tank'],
    "p2_m2" => ['Healer', 'healer'],
    "p2_m3" => ['Healer', 'healer'],
    "p2_m4" => ['DPS melee', 'dps_melee'],
    "p2_m5" => ['Mago', 'mago'],
    "p3_m1" => ['Mago', 'mago'],
    "p3_m2" => ['Mago', 'mago'],
    "p3_m3" => ['Mago', 'mago'],
    "p3_m4" => ['Mago', 'mago'],
    "p3_m5" => ['Mago', 'mago'],
    "p4_m1" => ['Mago', 'mago'],
    "p4_m2" => ['Mago', 'mago'],
    "p4_m3" => ['DPS Melee', 'dps_melee'],
    "p4_m4" => ['DPS Melee', 'dps_melee'],
    "p4_m5" => ['Healer', 'healer'],
    "p5_m1" => ['Mago', 'mago'],
    "p5_m2" => ['Mago', 'mago'],
    "p5_m3" => ['DPS Melee', 'dps_melee'],
    "p5_m4" => ['DPS Melee', 'dps_melee'],
    "p5_m5" => ['Healer', 'healer'],
    "p6_m1" => ['Healer', 'healer'],
    "p6_m2" => ['DPS Melee', 'dps_melee'],
    "p6_m3" => ['DPS Melee', 'dps_melee'],
    "p6_m4" => ['DPS Melee', 'dps_melee'],
    "p6_m5" => ['Mago', 'mago'],
    "p7_m1" => ['Healer', 'healer'],
    "p7_m2" => ['DPS Melee', 'dps_melee'],
    "p7_m3" => ['DPS Melee', 'dps_melee'],
    "p7_m4" => ['DPS Melee', 'dps_melee'],
    "p7_m5" => ['Mago', 'mago'],
    "p8_m1" => ['Tank', 'tank'],
    "p8_m2" => ['Healer', 'healer'],
    "p8_m3" => ['DPS Melee', 'dps_melee'],
    "p8_m4" => ['DPS Melee', 'dps_melee'],
    "p8_m5" => ['Mago', 'mago'],
    "p9_m1" => ['Tank', 'tank'],
    "p9_m2" => ['Healer', 'healer'],
    "p9_m3" => ['DPS Melee', 'dps_melee'],
    "p9_m4" => ['DPS Melee', 'dps_melee'],
    "p9_m5" => ['Mago', 'mago']
  }

  attr_accessor :p0_m1, :p0_m2, :p0_m3, :p0_m4, :p0_m5,
                :p1_m1, :p1_m2, :p1_m3, :p1_m4, :p1_m5,
                :p2_m1, :p2_m2, :p2_m3, :p2_m4, :p2_m5,
                :p3_m1, :p3_m2, :p3_m3, :p3_m4, :p3_m5,
                :p4_m1, :p4_m2, :p4_m3, :p4_m4, :p4_m5,
                :p5_m1, :p5_m2, :p5_m3, :p5_m4, :p5_m5,
                :p6_m1, :p6_m2, :p6_m3, :p6_m4, :p6_m5,
                :p7_m1, :p7_m2, :p7_m3, :p7_m4, :p7_m5,
                :p8_m1, :p8_m2, :p8_m3, :p8_m4, :p8_m5,
                :p9_m1, :p9_m2, :p9_m3, :p9_m4, :p9_m5

  def member_for(position, attendees)
    position_role = party_format[position]
    filtered = attendees.select{|attendee| position_role.in?(attendee[:roles])}
    return [[position_role.humanize, nil]] unless filtered.any?
    [[position_role.humanize, nil], []] + filtered.map{|member| ["#{member[:name]} (#{position_role.humanize})", member[:id]]}
  end

  def member_at(position, attendees)
    if members
      member = attendees.select{|attendee| attendee[:id] == members[position].to_i}.first
      position_role = party_format[position]
      member.present? ? ["#{member[:name]} (#{position_role.humanize})", member[:id]] : []
    else
      []
    end
  end
end
