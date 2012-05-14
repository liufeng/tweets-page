#!/usr/bin/env ruby

USERNAME = 'liufeng'

require 'twitter'

Twitter.user_timeline(USERNAME, :count => 20).each do |tweet|
  puts "#{tweet.id} #{tweet.created_at} #{tweet.text}"
end
