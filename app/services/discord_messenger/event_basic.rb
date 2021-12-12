class DiscordMessenger::EventBasic
  def initialize(event:, setup: nil)
    @event = event
    @setup = DiscordSetup.find_by_id(setup)
    @tts = false
    @attachments = nil
    @allowed_mentions = nil
    @message_reference = nil
    @starts_at_utc = @event.starts_at + 3.hours
  end

  def components
    buttons = Discordrb::Components::View.new do |v|
      v.row do |r|
        r.button(style: :primary, label: 'Voy a ir', custom_id: "accept_event:event_id_#{@event.id}")
        r.button(style: :secondary, label: 'No puedo ir', custom_id: "decline_event:event_id_#{@event.id}")
      end
    end
  end

  def embed_hash
    url = "https://www.lokthar.com/logo-clear.png"
    description = <<-EOS
      #{EmojiWritter.new(@event.name).process}

      <:calendar_date:919712480530432040> #{I18n.l(@event.starts_at, format: '%A %e a las %-H:%M')} [-3GMT] (<t:#{@starts_at_utc.to_i}:R>)

      #{@event.event_details}
    EOS

    embed_hash = {
      :title=>@event.name,
      :description => description,
      :url=>nil,
      :color=>0x8700f5,
      :timestamp => @starts_at_utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
      :footer=>{
        :icon_url => "https://i.imgur.com/61tyXNu.png",
        :text => "Si tienen algun problema con el bot, PM a Ksix"
      },
      :image=>{ :url => Event::EVENT_BANNER[@event.location] },
      :thumbnail=>nil,
      :video=>nil,
      :provider=>nil,
      :author=>nil
    }
  end

  def republish
    @event.discord_messages.each do |msg_log|
      message = DiscordBot.bot.channel(msg_log["channel"]).message(msg_log["message"])
      message.edit("@everyone", embed_hash) if message
    end
  end

  def deliver
    DiscordSetup.all.each do |discord_setup|
      message = DiscordBot.bot.channel(discord_setup.channel_id).send_message("", @tts, embed_hash, @attachments, @allowed_mentions, @message_reference, components)

      discord_messages = @event.discord_messages || []
      discord_messages << {channel: message.channel.id, message: message.id}

      @event.update(discord_messages: discord_messages)
    end
  end
end
