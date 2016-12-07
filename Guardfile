require 'asciidoctor'
require 'pathname'
current_dir = Pathname.new("/mirror/src")

guard :shell do
  watch(%r{/mirror/assets/.*}) {|m|
    p "Sync assets to public"
    `rsync -avh --del /documents/assets /documents/public`
  }

  watch(%r{(.+\.adoc)}) {|m|
    p "Build document with #{m[1].to_s}"
    dir = Pathname.new(m[1]).expand_path.dirname
    base = Pathname.new(m[1]).basename(".adoc")
    rel = dir.relative_path_from(current_dir)
    rel = rel / base
    `asciidoctor -o /documents/public/#{rel.to_s}.html #{m[1]}`
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
