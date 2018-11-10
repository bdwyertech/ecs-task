.PHONY: all dep build

OUTPUT = ecs-task
BUILD_CMD = go build -a -tags netgo -installsuffix netgo --ldflags '-extldflags "-static"'
VERSION = v1.0.0

all: mac linux windows

dep: Gopkg.lock
	dep ensure

mac: dep
	GOOS=darwin GOARCH=amd64 $(BUILD_CMD) -o $(OUTPUT)
	zip packages/$(OUTPUT)_${VERSION}_darwin_amd64.zip $(OUTPUT)

linux: dep
	GOOS=linux GOARCH=amd64 $(BUILD_CMD) -o $(OUTPUT)
	zip packages/$(OUTPUT)_${VERSION}_linux_amd64.zip $(OUTPUT)

windows: dep
	GOOS=windows GOARCH=amd64 $(BUILD_CMD) -o $(OUTPUT).exe
	zip packages/$(OUTPUT)_${VERSION}_windows_amd64.zip $(OUTPUT).exe
