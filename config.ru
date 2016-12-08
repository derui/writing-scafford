#\ -d -p 3000 -o 0.0.0.0
require 'rack-livereload'

use Rack::LiveReload, live_reload_port: 35730
run Rack::Static.new(nil, :urls => [""], :root => '/documents/public', :index => 'index.html')

