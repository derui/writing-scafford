require 'pathname'
@current_dir = Pathname.new("/mirror/src")

@current_user = ENV['USER_ID']
@current_group = ENV['USER_GROUP']

guard :livereload, port: '35729' do
  watch(%r{mirror/public/(.+\.html$)}) {|m| "#{m[1]}"}
end

guard :shell do
  watch(%r{/mirror/assets/.*}) {|m|
    p "Sync assets to public"
    `rsync -avh --del /documents/assets/* /documents/public`
    `find /document/public -exec chown #{@current_user}:#{@current_group} {} \;`
  }

  watch(%r{(.+\.adoc)}) {|m|
    p "Build document with #{m[1].to_s}"
    `asciidoctor -r asciidoctor-diagram -o /documents/public/index.html /documents/assets/index.adoc`
    `find /document/public -exec chown #{@current_user}:#{@current_group} {} \;`
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
