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

  task :eps_from_rss => :environment do
    require 'open-uri'
    doc = Nokogiri::HTML(open('http://feeds.feedburner.com/uhhyeahdude/podcast'))
    doc.css("item").each do |epi|
      number = epi.search('title').text.match(/Episode (\d+)/)[1]
      description = epi.search('description').text
      url = epi.search('enclosure').first.try(:[], 'url')
      pubdate = epi.search('pubdate').text
      episode = Episode.find_or_create_by(number: number)
      episode.title = "Episode #{number}"
      episode.description = description
      episode.public_url = url if url
      episode.published_at = DateTime.parse(pubdate)
      episode.save
    end
  end
end
