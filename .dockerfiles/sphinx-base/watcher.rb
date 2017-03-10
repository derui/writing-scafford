#!/usr/bin/ruby

while true do
  `rsync -ogavh --del /documents/doc/source/ /mirror/`
  sleep 1
end
