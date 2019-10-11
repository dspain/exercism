#!/Users/damianspain/.rvm/rubies/ruby-2.4.0/bin/ruby

require 'json'
require 'fileutils'

exercise_id = ARGV[0]
track_id = ARGV[1] || "elixir"
puts exercise_id
puts track_id
result = `curl -X GET \
  'https://api.exercism.io/v1/solutions/latest?exercise_id=#{exercise_id}&track_id=#{track_id}' \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Authorization: Bearer 5dde3c4b-4b82-437f-9b97-ac79df28b7ed' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: site_context=normal; _exercism_session=HURavnbU%2F1GRYUPrsxmyOYzGCo00mSmRPREqtjJkJJ73ivQX5obiPuTrcQD88bP8RSUk3lFVg1ABvhcxEhjuvIyeNn2Tn58667Lu%2BMCOKTYLxioyuRnZ0EXcYLrOcTOiAvh%2BCEBJr16QxnLMvmnyKb2E6S8KkVHDBThQXxeuQ7iSUtIvjj8zuvm1CLHf9oWfQgevLqzCZBitsLT%2Fjjdk9TRmcTKcbk1f5DJsJbJltdeA1ctdQC9ofHWWOpJt63ZcpZP%2FNMszhw%3D%3D--QVjCcvOQD7PgMHjO--oo%2FZ%2FTrCkUzWfHbsN3%2FEhg%3D%3D' \
  -H 'Host: api.exercism.io' \
  -H 'Postman-Token: c067fc6f-1c9c-439f-b2b9-c5f4f3bd1c7e,2f624f98-b20b-4634-9bad-d576a4bca149' \
  -H 'User-Agent: PostmanRuntime/7.15.2' \
  -H 'cache-control: no-cache'`


data = JSON.parse(result)
id = data["solution"]["id"]
files = data["solution"]["files"]
puts files
base_dir = track_id + "/" + exercise_id
files.each do |file|
  puts "#{file}: "
  this_file_text = `curl -X GET \
  https://api.exercism.io/v1/solutions/#{id}/files/#{file} \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Authorization: Bearer 5dde3c4b-4b82-437f-9b97-ac79df28b7ed' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Cookie: site_context=normal; _exercism_session=SnPfRkBUym%2BuBjNNkyjM5wsNLeGYMpF%2BcWU2prsh5%2F8fO6WHWsmVB6qKpK5i0yHwFX2xbPZ2fy19rMbJl2wvQGo7HTvYyBY2p33boHiaI61dlFrRprGsXaz42tznv%2FrvxmJIMbKog2Z%2BkE4qSHXPu2flmfNhKMAJOMs%2Bl%2BW0s7%2FXx5sNL3aOqyunVwg8y02n%2FwSUn2Ev6%2F4%2BlDgKjMxpYj6NlDn9cvsRMATliDqPwLtymm3%2F8HqgV%2FHxLWYyadTJd3qmJpxwAw%3D%3D--OY7NXyz24zKjeToI--1rSqV9Vk9FHZv3t3v3ChhA%3D%3D' \
  -H 'Host: api.exercism.io' \
  -H 'Postman-Token: 9a2afc54-12be-4ae0-bf78-96576bdf4357,2bd12dfe-ecf5-4570-aa39-86e09637e0c4' \
  -H 'User-Agent: PostmanRuntime/7.15.2' \
  -H 'cache-control: no-cache'`
  total_name = base_dir + "/" + file
  dirname = File.dirname(total_name)
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
  File.write(total_name, this_file_text)
end

puts "ID: #{id}"
