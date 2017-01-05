require 'pathname'
@current_dir = Pathname.new("/mirror/src")

def get_relative_path(path, rel_dir)
  dir = Pathname.new(path).expand_path.dirname
  base = Pathname.new(path).basename
  rel = dir.relative_path_from(rel_dir)
  rel / base
end

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
    rel = get_relative_path(m[1], @current_dir)
    `asciidoctor -r asciidoctor-diagram -o /documents/public/#{rel.basename(".adoc").to_s}.html #{m[1]}`
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
