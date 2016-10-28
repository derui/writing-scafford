require 'asciidoctor'

guard 'shell' do
  watch(/^src\/.*\.adoc$/) {|m|
    Asciidoctor.convert_file m[0]
  }
end

guard 'livereload' do
  watch(%r{^.+\.(css|js|html)$})
end
