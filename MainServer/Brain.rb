require "webrick"

server= WEBrick::HTTPServer.new :Port => 8000

trap 'INT' do server.shutdown end

server.mount_proc '/youtube' do |req, res|
  if req.query["url"]
  	res.body=req.query["url"]
  	youtubeURL	= req.query["url"]
  	puts "Got Request to download : " + youtubeURL
  	%x[youtube-dl --extract-audio --audio-format mp3 #{youtubeURL}]
  	puts "Downloaded: " + youtubeURL
  else
  	res.body="No URL"
  end
end

server.start

puts "here"