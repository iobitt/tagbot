# frozen_string_literal: true

require_relative 'api'

class Bot
  def initialize(token)
    @token = token
    @api = Api.new(token)
  end

  def run
    while true
      updates = @api.get_updates
      puts JSON.pretty_generate updates

      update = updates.last
      text = update['message']['text']
      is_bot = update['message']['from']['is_bot']
      username = update['message']['from']['username']

      case text
      when '/get_members_list'
        get_members_list
      end

      sleep 60
      break
    end
  end
end
