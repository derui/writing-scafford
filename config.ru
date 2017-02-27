#\ -d -p 3000 -o 0.0.0.0
run Rack::Static.new(nil, :urls => [""], :root => '/documents/public', :index => 'index.html')

