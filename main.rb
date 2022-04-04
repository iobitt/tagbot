require_relative 'src/bot'

def read_token
  File.read('.token').split.first
end

def main
  token = read_token
  bot = Bot.new(token)
  bot.run
end

main
