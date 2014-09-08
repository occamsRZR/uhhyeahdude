atom_feed do |feed|
  feed.title "Uhh Yeah Dude Archives"
  feed.link(rel: "next", href: "http://33.33.33.6:3000/episodes?page=2")
  @episodes.each do |episode|
    feed.entry episode, published: episode.published_at do |entry|
      entry.title episode.title
      entry.link(rel: "enclosure", title: "MP3", href: episode.public_url, type: 'audio/mpeg')
      entry.content(src: episode.public_url, type: "audio/mpeg")
      entry.updated episode.published_at
      entry.author "Jah and Seth"
      entry.url episode.public_url
      entry.guid episode.public_url
      entry.enclosure(url: episode.public_url, type: "audio/mpeg")
    end
  end
end
