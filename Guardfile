require 'pathname'
@current_dir = Pathname.new("/mirror/src")

guard :livereload, port: '35729' do
  watch(%r{mirror/public/(.+\.html$)}) {|m| "#{m[1]}"}
end

guard :shell do
  watch(%r{/mirror/assets/.*}) {|m|
    p "Sync assets to public"
    `rsync -avh --del /documents/assets /documents/public`
  }

  watch(%r{(.+\.adoc)}) {|m|
    p "Build document with #{m[1].to_s}"
    `asciidoctor -r asciidoctor-diagram -o /documents/public/index.html /documents/src/index.adoc`
  }

  Process.fork do
    trap("INT") { exit 0}
    `ruby /watcher.rb`
  end

  Process.fork do
    trap("INT") {exit 0}
    `rackup /documents/config.ru`
  end
end
