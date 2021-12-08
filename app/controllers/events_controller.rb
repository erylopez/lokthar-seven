class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def publish
    @event.update(published_at: Time.now)

    buttons = Discordrb::Components::View.new do |v|
      v.row do |r|
        r.button(style: :primary, label: 'Voy a ir', custom_id: "accept_event:event_id_#{@event.id}")
        r.button(style: :secondary, label: 'No puedo ir', custom_id: "decline_event:event_id_#{@event.id}")
      end
    end
    tts = false
    embed = nil
    attachments = nil
    allowed_mentions = nil
    message_reference = nil
    components = buttons
    url = "https://www.lokthar.com/logo-clear.png"

    builder = Discordrb::Webhooks::Builder.new
    builder.add_embed do |e|
      e.title = @event.name
      e.description = 
      # e.image = Discordrb::Webhooks::EmbedImage.new(url: url)
      # e.author = Discordrb::Webhooks::EmbedAuthor.new(name: "LKT Bot", icon_url: url)
      # e.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'Daily 猫 (cat)')
      e.colour = 0x36393F
      e.timestamp = Time.now
    end

    embed_hash = {
      :title=>@event.name,
      :description=>"#{EmojiWritter.new(@event.name).process} \n\n#{@event.event_details}",
      :url=>nil,
      :timestamp=>"2021-11-28T20:05:20Z",
      :color=>0x8700f5,
      :footer=>{
        :icon_url => "https://i.imgur.com/61tyXNu.png",
        :text => "Si tienen algun problema con el bot, PM a Ksix"
      },
      :image=>{ :url => Event::EVENT_BANNER[@event.location] },
      :thumbnail=>nil,
      :video=>nil,
      :provider=>nil,
      :author=>nil
      # :fields=>[
      #   { name: "Party 1", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 2", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 3", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 5", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 6", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 7", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 8", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 9", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true},
      #   { name: "Party 10", value: "Tank\nHealer\nDPS Melee\nDPS Melee\nMago", inline: true}
      # ]
    }

    puts builder.embeds.map(&:to_hash).first

    # DiscordBot.bot.channel(916413902265384990).send_message("", tts,embed_hash, attachments, allowed_mentions, message_reference, components)
    DiscordSetup.all.each do |discord_setup|
      message = DiscordBot.bot.channel(discord_setup.channel_id).send_message("", tts,embed_hash, attachments, allowed_mentions, message_reference, components)

      discord_messages = @event.discord_messages || []
      discord_messages << {channel: message.channel.id, message: message.id}

      @event.update(discord_messages: discord_messages)
    end

    redirect_to @event
  end

  protected

  def set_event
    @event = Event.find(params[:id] || params[:event_id])
  end

  def event_params
    params.require(:event).permit(:activity, :name, :starts_at,
      :location, :tanks_needed, :healers_needed, :melee_dps_needed,
      :ranged_dps_needed, :mages_needed, :event_details, :event_image_url
    )
  end

end
