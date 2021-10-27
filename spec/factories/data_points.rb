# frozen_string_literal: true

FactoryBot.define do
  factory :data_point do
    channel
    value { 100 }
  end
end
