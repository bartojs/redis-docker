run:
	docker run -d --name redis redis

build:
	docker build -t redis .

cleanup:
	docker ps -a | awk '/Exited /{print$$1}' | xargs docker rm -f
	docker images -q -a -f 'dangling=true' | xargs docker rmi -f
