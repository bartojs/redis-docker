run:
	docker run -d -p 6379:6379 -v /var/data/redis:/data --name redis1 bartojs/redis

build:
	docker build -t bartojs/redis .

cleanup:
	docker ps -a | awk '/Exited /{print$$1}' | xargs docker rm -f
	docker images -q -a -f 'dangling=true' | xargs docker rmi -f
