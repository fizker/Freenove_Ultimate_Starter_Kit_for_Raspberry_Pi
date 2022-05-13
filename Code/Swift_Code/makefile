.PHONY: build start-build-server host-file-server
.SILENT:

build:
	swift build

start-build-server:
	docker run -it --rm \
		--mount type=bind,source="$(shell pwd)"/,destination=/code,consistency=cached \
		swift:5.6-focal

node_modules/.bin/serve:
	echo '{"dependencies":{"serve":"*"}}' > package.json
	npm i serve
	rm package.json package-lock.json

host-file-server: node_modules/.bin/serve
	./node_modules/.bin/serve -l 35000 .build/debug
