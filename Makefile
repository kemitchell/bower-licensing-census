all: license-frequencies.txt

license-frequencies.txt: packages
	node census.js | cut -f 2 | sort | uniq -c | sort -h | tac > "$@"

.PHONY: packages

packages: packages.json
	ruby download_bower_json_files.rb
	find package -name "*.json" | xargs -I FILE json --in-place -f "FILE"

packages.json:
	wget -c -O "$@" http://bower.herokuapp.com/packages
	json --in-place -f "$@"
