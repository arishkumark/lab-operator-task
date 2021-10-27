class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.references :device
      t.string :name
      t.timestamps
    end
  end
end
