# -*- coding: utf-8 -*-
namespace :migrations do
  namespace :wiki_entries do
    task :parse_topics => :environment do
      Episode.all.each do |episode|
        doc = Nokogiri::HTML(episode.wecks_entry)
        doc.css("b").each do |topic|
          topic_name = topic.children.children.text
          puts "Imported Topic: #{topic_name}"
        end
      end
    end

    task :parse_timestamps => :environment do
      unparsed = 0
      nodescription = 0
      full_timestamp = 0
      Episode.all.each do |episode|
        doc = Nokogiri::HTML(episode.wecks_entry)
        topic_name = "NOTTATOPIC"
        doc.css("p").each do |p|
          # Next if this is just the category episode thing
          next if p.text.eql? "Category:Episodes"
          # Next if this is italics (usually air date)
          next if p.children.first.name.eql?  "i"
          # set the topic name of the bold element
          topic_name = p.children.first.text if p.children.first.name.eql? "b"
          # Next if there is no topic set
          next if topic_name.eql? "NOTTATOPIC"
          timestamp = ""
          if p.text[/^(\d+)*:*(\d+):(\d{2})\s*–*-* (.+)$/]
            hour = $1.to_i
            minute = $2.to_i
            second = $3.to_i
            total_seconds = (hour * 3600) + (minute * 60) + second
            description = $4
            timestamp = "hour: #{hour} minute: #{minute} second: #{second} #{description}"
            EpisodeTimestamp.find_or_create_by(timestamp: total_seconds,
                                               description: description,
                                               episode: episode
                                               )
            full_timestamp += 1
          elsif p.text[/^(\d{2})*:*(\d{2}):(\d{2})/]
            hour = $1
            minute = $2
            second = $3
            timestamp = "hour: #{hour} minute: #{minute} second: #{second}"
            nodescription += 1
          else
            next if topic_name.eql? "Seatbelts"
            next if topic_name.eql? p.text
            unparsed += 1
          end
        end
      end
      # the
      puts "#{unparsed} records weren't parsed"
      puts "#{nodescription} records weren't described"
      puts "#{full_timestamp} records were fully described"
    end
  end
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
