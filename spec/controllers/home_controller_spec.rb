# frozen_string_literal: true

require 'rails_helper'

describe HomeController do
  render_views

  describe 'GET /' do
    it 'returns an empty container for react to mount to' do
      get :show

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('react-root')
    end
  end
end
