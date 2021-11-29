unless ActiveModel::Type::Boolean.new.cast(ENV['SKIP_BOTS'])
  require 'discordrb'

  module DiscordBot
    def initialize_bot
      @bot ||= Discordrb::Commands::CommandBot.new(
        token: "ODk4NjA0MzgyNzgwNzg4ODU2.YWmojA.gk69byxW_wuLLjsdnGgm4W-3j5Y",
        prefix: 'nw!',
        intents: [:server_messages]
      )

      # @bot.bucket :nicks, limit: 1, time_span: 11, delay: 10

      @event = nil

      @bot.command(:test) do |event, *args|
        # user = HTTParty.get("https://www.lokthar.com/api/v1/members/#{event.user.id}")
        event.channel.send("Testing initializer from rails 7")
      end

      @bot.command(:setup) do |event, *args|
        server = event.server.id
        channel = event.channel.id
        user = event.user.id

        puts "Server: #{server} || channel: #{channel} || user: #{user}"
      end

      @bot.button(custom_id: /accept_event/) do |event|
        event_id = event.custom_id.split("accept_event:event_id_").last
        event_record = Event.find(event_id)

        attendee = EventAttendee.where(discord_id: event.user.id, event: event_record).first_or_create do |attendee|
          attendee.name = "#{event.user.username}##{event.user.discord_tag}"
          attendee.from_server = event.server_id
          attendee.from_channel = event.channel.id
        end

        event.respond(content: "Elije hasta 3 roles que puedas ocupar en la guerra:", ephemeral: true) do |_, view|
          view.row do |r|
            r.select_menu(custom_id: "event_role_select:#{attendee.id}", placeholder: 'Que roles puedes cubrir?', max_values: 3) do |s|
              s.option(label: 'DPS Melee', value: 'dps_melee:attendee')
              s.option(label: 'Tank', value: 'tank')
              s.option(label: 'Healer', value: 'healer')
              s.option(label: 'Mago', value: 'mago')
              s.option(label: 'Arquero', value: 'arquero')
            end
          end
        end
      end

      @bot.button(custom_id: "decline_event:event_id_1") do |event|
        event.respond(content: "Gracias por avisar!", ephemeral: true)
      end

      @bot.select_menu(custom_id: /event_role_select/) do |event|
        attendee = EventAttendee.find(event.custom_id.split(":").last)
        attendee.update(role_1: event.values[0], role_2: event.values[1], role_3: event.values[2])
        event.respond(content: "Listo! pronto organizaremos las parties, te tendremos en cuenta para los siguientes roles: #{event.values.join(', ')}")
        puts "event id: #{event.custom_id}"
        puts "event user id: #{event.user.id}"
        puts "event user: tag: #{event.user.tag} ||name:#{event.user.name}||discriminator#{event.user.discriminator}||discordtag:#{event.user.discord_tag}||username:#{event.user.username}||avatar:#{event.user.avatar_url}"
        puts "event server #{event.server_id}"
        puts "event channel #{event.channel.id}"
      end

      @bot.run(:async)
      @bot
    end
    module_function :initialize_bot

    def bot
      @bot ||= initialize_bot
    end
    module_function :bot

  end

  DiscordBot.bot
end
