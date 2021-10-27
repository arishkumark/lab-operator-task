# frozen_string_literal: true

class Device < ApplicationRecord
  has_many :channels, dependent: :destroy
end
