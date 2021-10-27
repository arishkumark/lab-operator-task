# frozen_string_literal: true

require 'rails_helper'

describe Api::DataPointsController, type: :controller do
  describe 'GET /api/data_points' do
    before do
      5.times do |index|
        travel_to index.hours.from_now do
          create :data_point
        end
      end
    end

    it 'returns all data_points' do
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(5)
    end

    it 'can be filtered by time range' do
      get :index, format: :json, params: { filter: { created_at: { gt: 30.minutes.from_now, lt: 3.5.hours.from_now } } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(3)
    end
  end
end
