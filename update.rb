#!/usr/bin/env ruby

USERNAME = 'liufeng'
DATABASE = 'data.db'
OUTPUT = 'tweets.html'

require 'twitter'
require 'sequel'

DB = Sequel.sqlite(DATABASE)
db = DB[:tweets]

changed = false
Twitter.user_timeline(USERNAME, :count => 200).reverse.each do |tweet|
  if not db.filter(:id => tweet.id).first
    db.insert(:id => tweet.id, :created_at => tweet.created_at, :text => tweet.text)
    changed = true
  end
end

# Generate the output

if changed
  result = ""
  result << %{
<!DOCTYPE html>
<head>
  <meta charset="utf-8">
  <title>Feng Liu\'s Twitter Timeline</title>
  <meta name="author" content="Feng Liu">
</head>

<body>
<center><h1>Feng Liu\'s Twitter Timeline</h1></center>
<center><h5>Changes every 12 hours</h5></center>
<ul>
}
  db.reverse_each do |tweet|
    result << "  <li>#{tweet[:text]} <a href=\"http://twitter.com/#{USERNAME}/status/#{tweet[:id]}\">#{tweet[:created_at]}</a></li>"
  end

  result << %{
</ul>
</body>
</html>
}

  outfile = File.new(OUTPUT, "w")
  outfile.puts(result)
  outfile.close
end
