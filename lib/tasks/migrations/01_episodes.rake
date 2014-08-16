namespace :migrations do
  task :episodes => :environment do
    get_aws_connection
    @connection.directories.get('uhhyeahdude-archive', prefix: "episodes/").files.each do |file|
      # skip this record if it's empty (usually the directory root)
      next if file.content_length.zero?
      file_name = file.key.match /episodes\/(?<episode_file_name>.*)/
      file_name_info = file_name[:episode_file_name].match(/Episode (?<episode_number>\d+) (?<episode_info>.+)\.(mp3|mov)$/)
      file_episode_info = file_name_info[:episode_info]
      begin
        date_published = DateTime.parse(file_name_info[:episode_info])
        episode = Episode.find_or_create_by(
                     file_name: file_name[:episode_file_name],
                     published_at: date_published,
                     number: file_name_info[:episode_number],
                     public_url: file.public_url
                     )
        puts "Episode #{episode.number}, #{episode.published_at} was imported"
      rescue Exception => e
        puts "Episode #{file_name} wasn't imported because: #{e}"
      end
    end
  end

  def get_aws_connection
    @connection ||= Fog::Storage.new({
                                       provider: "AWS",
                                       aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                       aws_secret_access_key: ENV['AWS_SECRET_KEY']
                                     })

  end
end
