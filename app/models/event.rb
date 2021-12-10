class Event < ApplicationRecord
  ACTIVITIES = ["Defensa 50v50", "Ataque 50v50", "PvP openworld"]
  EVENT_BANNER = {
    "Windsward" => "https://i.imgur.com/YGHvxxi.png",
    "Brightwood" => "https://i.imgur.com/FeJnfDo.png",
    "Coutlass Keys" => "https://i.imgur.com/8jQ9BsE.png",
    "Ebonscale" => "https://i.imgur.com/JpMz9ND.png",
    "Everfall" => "https://i.imgur.com/2bcVuo1.png",
    "First Light" => "https://i.imgur.com/IYnHk49.png",
    "Monarchs Bluffs" => "https://i.imgur.com/srr9ZQA.png",
    "Mourningdale" => "https://i.imgur.com/GRw5hyO.png",
    "Restless Shore" => "https://i.imgur.com/9x6No8m.png",
    "Weavers Fen" => "https://i.imgur.com/pxDq6hB.png"
  }

  has_many :event_attendees
  has_one :event_party

  def edit_msg
    url = "https://www.lokthar.com/logo-clear.png"

    fields_hash = event_party.parties_hash.select{|party| party[:name] != "Party 4"}
    party_4     = event_party.parties_hash.select{|party| party[:name] == "Party 4"}.first[:value].split("\n").join(" - ")

    embed_hash = {
      :title=>name,
      :description=>"#{EmojiWritter.new(name).process} \n\n#{event_details}\n\n Editado de nuevo el : #{Time.now}. __Squad__: #{event_party.title}\n\n**Party 4** #{party_4 || "Armas de asedio"}",
      :url=>nil,
      :timestamp=>"2021-11-28T20:05:20Z",
      :color=>0x8700f5,
      :footer=>{
        :icon_url => "https://i.imgur.com/61tyXNu.png",
        :text => "Si tienen algun problema con el bot, PM a Ksix"
      },
      :image=>{ :url => Event::EVENT_BANNER[location] },
      :thumbnail=>nil,
      :video=>nil,
      :provider=>nil,
      :author=>nil,
      :fields=> fields_hash
    }

    discord_messages.each do |msg_log|
      message = DiscordBot.bot.channel(msg_log["channel"]).message(msg_log["message"])
      message.edit("@everyone", embed_hash) if message
    end
  end
end
