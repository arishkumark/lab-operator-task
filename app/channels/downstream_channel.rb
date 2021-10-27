# frozen_string_literal: true

class DownstreamChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'DataPoint'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
