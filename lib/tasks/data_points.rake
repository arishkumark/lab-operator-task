# frozen_string_literal: true

ConnectionStub = Class.new do
  def identifiers
    {}
  end

  def logger
    Rails.logger
  end
end

namespace :data_points do
  desc 'Simulate data points coming from all connected devices on interval'
  task simulate: :environment do
    wait_for_migration!
    wait_for_seeds!

    connection = ConnectionStub.new
    threads = Device.all.flat_map { |device|
      device.channels.map { |channel|
        Thread.new do
          last_value = channel.data_points.order(id: :desc).pick(:value) || default_value(channel)
          subscription = ExternalChannel.new connection, "Channel##{channel.id}", { id: channel.id }

          sleep rand
          loop do
            last_value = next_value(channel, last_value)

            subscription.perform_action 'value' => last_value

            sleep 1
          end
        end
      }
    }

    threads.map(&:join)
  end

  def wait_for_migration!
    loop do
      ActiveRecord::Migration.check_pending!
      break
    rescue StandardError
      sleep 5
    end
  end

  def wait_for_seeds!
    # see db/seeds.rb
    sleep 5 while Device.count < 3
    sleep 5 while Channel.count < 4
  end

  def default_value(channel)
    {
      weight: 100,
      rotation: 200,
      temperature: 30
    }[channel.name.to_sym]
  end

  def next_value(channel, last_value)
    delta, min, max = {
      weight: [5, 50, 150],
      rotation: [10, 0, 280],
      temperature: [4, 0, 200]
    }[channel.name.to_sym]

    [[min, last_value + (rand * delta - delta / 2)].max, max].min
  end
end
