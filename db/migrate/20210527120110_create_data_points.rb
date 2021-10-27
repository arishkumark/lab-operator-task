class CreateDataPoints < ActiveRecord::Migration[6.1]
  def change
    create_table :data_points do |t|
      t.references :channel
      t.float :value
      t.timestamps
    end
  end
end
