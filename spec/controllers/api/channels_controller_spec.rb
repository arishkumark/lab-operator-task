# frozen_string_literal: true

require 'rails_helper'

describe Api::ChannelsController, type: :controller do
  describe 'GET /api/channels' do
    let!(:channels) { create_list :channel, 5 }
    let!(:named_channel) { create :channel, name: 'rotation_speed' }

    it 'returns all channels' do
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(6)
    end

    it 'can be filtered by id' do
      get :index, format: :json, params: { filter: { id: [channels[1].id, channels[3].id] } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(2)
      expect(response.body).to be_json_eql(channels[1].to_json).at_path('0')
      expect(response.body).to be_json_eql(channels[3].to_json).at_path('1')
    end

    it 'can be filtered by name' do
      get :index, format: :json, params: { filter: { name: 'rotation_speed' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(1)
      expect(response.body).to be_json_eql(named_channel.to_json).at_path('0')
    end
  end
end
