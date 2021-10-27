# frozen_string_literal: true

require 'rails_helper'

describe ExternalChannel do
  let(:channel) { create :channel }

  it 'subscribed successfuly' do
    subscribe id: channel.id

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from(channel)
  end

  it 'record data point when message is received' do
    subscribe id: channel.id

    expect { perform :receive, value: 100 }.to change { channel.data_points.count }.by(1)
  end
end
