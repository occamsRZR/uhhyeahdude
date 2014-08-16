namespace :migrations do
  task :wiki_entries => :environment do
    require 'open-uri'
    Episode.all.each do |episode|
      epi_number = episode.number.to_s.rjust(3, '0')
      doc = Nokogiri::HTML(open("http://uhhyeahdude.com/index.php/wiki/Episode_#{epi_number}"))
      doc.css('h2').remove
      doc.css('.breadcrumb').remove
      episode.update_attributes(wecks_entry: doc.css('.entry').to_html)
    end
  end
end
