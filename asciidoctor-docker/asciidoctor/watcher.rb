#!/usr/bin/ruby

while true do
  `rsync -avh --del /documents/ /mirror/`
  sleep 1
end
