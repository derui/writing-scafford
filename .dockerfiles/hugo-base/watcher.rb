#!/usr/bin/ruby

while true do
  `rsync -ogavh --del /documents/ /mirror/`
  sleep 1
end
