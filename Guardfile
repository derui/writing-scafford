require 'asciidoctor'
require 'webrick'

guard 'shell' do
  watch(/^src\/.*\.adoc$/) {|m|
    Asciidoctor.convert_file m[0]
  }
end

WEBrick::HTTPServer.new(:DocumentRoot => "/documents", :Port => 3000).start
