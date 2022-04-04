# frozen_string_literal: true

require 'rest-client'
require "logger"
require 'json'

class Api
  BASE_URL = 'https://api.telegram.org/bot'

  def initialize(token)
    @token = token
  end

  def get_me
    url = get_url('getMe')
    make_request(url, {})
  end

  def get_updates
    url = get_url('getUpdates')
    make_request(url, {})
  end

  def forward_message(chat_id, from_chat_id, message_id)
    url = get_url('forwardMessage')

    params = {
      chat_id: chat_id,
      from_chat_id: from_chat_id,
      message_id: message_id
    }

    make_request(url, params)
  end

  private

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def get_url(method)
    "#{BASE_URL}#{@token}/#{method}"
  end

  def make_request(url, params)
    logger.debug(url)
    response = RestClient.post url, params
    body = JSON.parse response.body
    logger.info(response.code)
    logger.info(body)
    body
  end
end
