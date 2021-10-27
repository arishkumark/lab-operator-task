# frozen_string_literal: true

module Api
  class ChannelsController < Api::BaseController
    def index
      channels = filtered(Channel)

      respond_with channels
    end
  end
end
