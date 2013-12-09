require 'json'

raw_j = File.read("public/poi.json")
j = JSON.parse(raw_j)

j.each_pair do |k, v|
  p = Place.new
  p.longitude = v["longitude"]
  p.latitude = v["latitude"]
  p.name = v["name"]
  p.pic = "/img/" + v["pic"].split("/").last
  p.user = User.find 1
  p.save
end

