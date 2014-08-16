class AddFileNameToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :file_name, :string
  end
end
