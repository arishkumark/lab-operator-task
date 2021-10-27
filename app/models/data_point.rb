# frozen_string_literal: true

class DataPoint < ApplicationRecord
  belongs_to :channel

  after_commit :broadcast

  private

  def broadcast
    ActionCable.server.broadcast 'DataPoint', as_json
  end
end
