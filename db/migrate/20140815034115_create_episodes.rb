class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :description
      t.string :public_url
      t.datetime :published_at

      t.timestamps
    end
  end
end
