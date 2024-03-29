#!/usr/bin/env ruby
require "json"
require 'webrick'


root = File.expand_path '-path/public_html'

server = WEBrick::HTTPServer.new :Port =>3000


server.mount_proc '/' do |req, res|
  res.content_type = 'text/text'
  res.body = "#{req.header["cookie"]}"

end

trap('INT') {server.shutdown}
server.start
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
