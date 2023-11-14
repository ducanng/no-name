dep:
	go mod tidy
	go mod download
build:
	go build -v -o ./bin/main .
build_deploy:
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o functions/main ./src/main.go
run:
	./bin/main
generate:
	swag init --ot go,yaml -d ./
	swag fmt
clean:
	rm -rf ./bin
all:
	make clean
	make generate
	make dep
	make build
	make run
deploy:
	make clean
	make dep
	make build_deploy