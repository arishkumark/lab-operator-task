# frozen_string_literal: true

class ExternalChannel < ApplicationCable::Channel
  def subscribed
    stream_from channel
  end

  def receive(data)
    channel.data_points.create!(value: data['value'])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def channel
    @channel ||= Channel.find(params[:id])
  end
end
