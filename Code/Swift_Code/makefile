.PHONY: build start-build-server host-file-server
.SILENT:

build:
	swift build

start-build-server:
	docker build --tag swift-rpi:6.1-noble .
	docker run -it --rm \
		--mount type=bind,source="$(shell pwd)"/,destination=/code,consistency=cached \
		swift-rpi:6.1-noble

node_modules/.bin/serve:
	echo '{"dependencies":{"serve":"*"}}' > package.json
	npm i serve
	rm package.json package-lock.json

host-file-server: node_modules/.bin/serve
	./node_modules/.bin/serve -l 35000 .build/debug

host-script-server: node_modules/.bin/serve
	./node_modules/.bin/serve -l 35001 raspberry-scripts
