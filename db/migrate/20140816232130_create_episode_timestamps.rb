class CreateEpisodeTimestamps < ActiveRecord::Migration
  def change
    create_table :episode_timestamps do |t|
      t.integer :timestamp
      t.text :description
      t.references :episode, index: true

      t.timestamps
    end
  end
end
