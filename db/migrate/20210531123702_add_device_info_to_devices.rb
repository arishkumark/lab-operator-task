class AddDeviceInfoToDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :devices, :category, :string
    add_column :devices, :vendor, :string
    add_column :channels, :unit, :string
  end
end
