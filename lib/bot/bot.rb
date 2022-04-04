# frozen_string_literal: true

require 'lib/bot/api'

class Bot
  def initialize(token)
    @api = Api.new(token)
  end

  def last_update
    return @last_update if @last_update
    @last_update = AdditionalField.find_by(name: 'update_id')
    @last_update ||= AdditionalField.create(name: 'update_id', value: '0')
  end

  def run
    while true
      updates = @api.get_updates

      if last_update.value.to_i == 0
        update = updates['result'].last
        return unless update
        last_update.update_column(:value, update['update_id'].to_s)
      end

      filtered_updates = updates['result'].reject do |update|
        return false if last_update.value.to_i == 0
        update['update_id'] <= last_update.value.to_i
      end

      filtered_updates.each do |update|
        update_id = update['update_id']
        message = update['message']
        channel_post = update['channel_post']

        if message.present?
          text = message['text']
          chat_id = message['chat']['id']
          parts = text.split(' ')
          if parts.first == '/add_team'
            # TODO: отправить сообщение об ошибке
            unless parts[1].blank?
              Team.find_or_create_by(tag: parts[1].downcase, chat_id: chat_id)
            end
          end
        end

        if channel_post.present?
          text = channel_post['text']
          chat_id = channel_post['chat']['id']
          message_id = channel_post['message_id']
          team_tags = text.scan(/@(\w+)/).map { |el| el.first }

          team_chat_ids = Team.where(tag: team_tags).pluck(:chat_id)
          team_chat_ids.each do |team_chat_id|
            @api.forward_message(team_chat_id, chat_id, message_id)
          end
        end

        last_update.update_column(:value, update_id.to_s)
      end

      sleep 30
    end
  end
end
