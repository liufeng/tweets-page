#!/usr/bin/env ruby

USERNAME = 'liufeng'
DATABASE = 'data.db'

require 'twitter'
require 'sequel'

DB = Sequel.sqlite(DATABASE)

db = DB[:tweets]

Twitter.user_timeline(USERNAME, :count => 200).reverse.each do |tweet|
  if not db.filter(:id => tweet.id).first
    db.insert(:id => tweet.id, :created_at => tweet.created_at, :text => tweet.text)
    puts "#{tweet.created_at}"
  end
end
