#!/usr/bin/env ruby

require 'json'


categories = Dir.entries("videos").reject{|entry| entry =~ /^.{1,2}$/}

titles = []

categories.each do |cat|
  o  = {
    title: cat
  }

  titles << o
end

pp "titles: ", titles

File.open("app/json/titles.json", "w+") do |f|
  f << titles.to_json
end

def amazon_url(cat, name)
  "https://roku-test-channel.s3.amazonaws.com/#{cat}/#{name}"
end


categories.each do |cat|
  entries = Dir.entries("videos/#{cat}").reject{|entry| entry =~ /^.{1,2}$/} 

  pp entries

  videos = []

  entries.each do |vid|
    url = amazon_url(cat,vid)
    o = {
      Title: "Title",
      Description: "Description",
      Image: "http://rokudev.roku.com/rokudev/examples/videoplayer/images/DavidKelley.jpg",
      Link: "#{url}",
      Url: "#{url}"
    }

    videos << o
  end

  pp videos

  File.open("app/json/videos.json", "w+") do |f|
    f << videos.to_json
  end
end
