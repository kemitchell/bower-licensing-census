all: packages

.PHONY: packages

packages: packages.json
	ruby download_bower_json_files.rb

packages.json:
	wget -c -O "$@" http://bower.herokuapp.com/packages
	json --in-place -f "$@"
