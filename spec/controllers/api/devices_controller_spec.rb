# frozen_string_literal: true

require 'rails_helper'

describe Api::DevicesController, type: :controller do
  describe 'GET /api/devices' do
    let!(:devices) { create_list :device, 5 }
    let!(:named_device) { create :device, name: 'Stirrer' }

    it 'returns all devices' do
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(6)
    end

    it 'can be filtered by id' do
      get :index, format: :json, params: { filter: { id: [devices[1].id, devices[3].id] } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(2)
      expect(response.body).to be_json_eql(devices[1].to_json).at_path('0')
      expect(response.body).to be_json_eql(devices[3].to_json).at_path('1')
    end

    it 'can be filtered by name' do
      get :index, format: :json, params: { filter: { name: 'Stirrer' } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(1)
      expect(response.body).to be_json_eql(named_device.to_json).at_path('0')
    end
  end
end
