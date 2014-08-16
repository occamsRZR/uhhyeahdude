class AddWecksEntryToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :wecks_entry, :text
  end
end
