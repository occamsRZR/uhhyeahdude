class AddAttachmentAudioTrackToEpisodes < ActiveRecord::Migration
  def self.up
    change_table :episodes do |t|
      t.attachment :audio_track
    end
  end

  def self.down
    remove_attachment :episodes, :audio_track
  end
end
