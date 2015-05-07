xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do
  xml.channel do
    xml.title "UYD Archives"
    xml.description "Archives for all episodes of Uhh Yeah Dude"
    xml.link root_url

    for episode in @episodes
      xml.item do
        xml.title episode.title
        xml.description episode.description
        xml.pubDate episode.published_at.to_s(:rfc822)
        xml.enclosure :url => episode.public_url, :type => 'audio/mpeg3'
        xml.link episode.audio_url
        xml.guid episode_url(episode)
      end
    end
  end
end