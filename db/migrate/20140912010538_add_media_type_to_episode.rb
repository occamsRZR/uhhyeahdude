class AddMediaTypeToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :media_type, :string, default: "audio"
  end
end
