# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    respond_to :json

    private

    def filtered(klass)
      params.fetch(:filter, {}).to_unsafe_h.reduce(klass.all) do |resources, filter|
        key, value = filter

        if value.is_a?(Hash)
          value.reduce(resources) do |sub_resources, sub_filter|
            sub_resources.where(klass.arel_table[key].send(*sub_filter))
          end
        else
          resources.where(key => value)
        end
      end
    end
  end
end
