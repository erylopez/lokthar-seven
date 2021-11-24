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
