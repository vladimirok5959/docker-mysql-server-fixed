VERSION="1.0.0"

docker-build:
	@-docker rmi docker-mysql-server-fixed:latest
	docker build -t docker-mysql-server-fixed:latest ./

docker-export:
	@-rm ./build/docker-mysql-server-fixed.tar
	docker save docker-mysql-server-fixed:latest > ./build/docker-mysql-server-fixed.tar

docker-import:
	@-docker rmi docker-mysql-server-fixed:latest
	docker load < ./build/docker-mysql-server-fixed.tar

docker-test:
	docker run --rm \
		--network host \
		--name docker-mysql-server-fixed-test \
		-e MYSQL_ROOT_PASSWORD="root" \
		-e MYSQL_DATABASE="my_test_base" \
		-e MYSQL_USER="my_test_user" \
		-e MYSQL_PASSWORD="my_test_pass" \
		-v /etc/timezone:/etc/timezone:ro \
		-it docker-mysql-server-fixed:latest

docker-push:
	docker tag docker-mysql-server-fixed:latest vladimirok5959/mysql-server-fixed:${VERSION}
	docker tag docker-mysql-server-fixed vladimirok5959/mysql-server-fixed:latest
	docker login
	docker push vladimirok5959/mysql-server-fixed:${VERSION}
	docker push vladimirok5959/mysql-server-fixed:latest
	docker rmi vladimirok5959/mysql-server-fixed:${VERSION}
	docker rmi vladimirok5959/mysql-server-fixed:latest
	docker rmi docker-mysql-server-fixed:latest
