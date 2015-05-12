require 'json'

system('mkdir -p packages')

JSON.parse(File.read('packages.json')).each do |package|
  package_name = package['name']
  url = package['url']
  bower_json_url = url
                   .sub('git://', 'http://')
                   .sub('github.com', 'raw.githubusercontent.com')
                   .sub(/\.git$/, '/master/bower.json')
  puts bower_json_url
  system("wget -c -O \"packages/#{package_name}.json\" \"#{bower_json_url}\"")
  sleep 2
end
