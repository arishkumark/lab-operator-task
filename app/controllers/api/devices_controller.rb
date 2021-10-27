# frozen_string_literal: true

module Api
  class DevicesController < Api::BaseController
    def index
      devices = filtered(Device)

      respond_with devices.as_json
    end
  end
end
