require 'asciidoctor'

guard :shell do
  watch(%r{(.+)\.adoc}) {|m|
    `asciidoctor -o /documents/public/index.html /documents/src/index.adoc`
  }

  Process.fork do
    trap("INT") { exit 0}
    `ruby /watcher.rb`
  end

  Process.fork do
    require 'webrick'
    webrick = WEBrick::HTTPServer.new({
      :DocumentRoot => '/documents/public/',
      :BindAddress => '0.0.0.0',
      :Port => 3000
    })
    trap("INT") { webrick.shutdown }
    webrick.start

  end
end
