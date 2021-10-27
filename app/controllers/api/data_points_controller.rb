# frozen_string_literal: true

module Api
  class DataPointsController < Api::BaseController
    def index
      data_points = filtered(DataPoint)

      respond_with data_points
    end
  end
end
