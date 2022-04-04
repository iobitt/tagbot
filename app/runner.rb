# frozen_string_literal: true

require 'lib/bot/bot'

class Runner
  def self.start
    puts 'Start'
    token = ENV.fetch('BOT_TOKEN')
    bot = Bot.new(token)
    bot.run
  end
end
