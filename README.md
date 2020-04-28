# docker-mysql-server-fixed

Docker image of fixed MySQL with mysql_native_password flag and utf8mb4 encoding. MySQL version 8.0.19. Config setting changed only for `character-set` encoding to recommended `utf8mb4`, added `default_authentication_plugin = mysql_native_password` to allow connect as it was previously and added time zone bind from host machine. Data directory is not change and located here `/var/lib/mysql`. Time zone can be binded at container startup from host machine by `-v /etc/timezone:/etc/timezone:ro`. All else from original MySQL image.

Docker image: [https://hub.docker.com/repository/docker/vladimirok5959/mysql-server-fixed](https://hub.docker.com/repository/docker/vladimirok5959/mysql-server-fixed)

## Makefile

* **make docker-build** - build docker image
* **make docker-export** - export docker image to file
* **make docker-import** - import docker image from file
* **make docker-test** - run test container
* **make docker-push** - push image to docker hub

## Running docker container

```sh
docker run \
    --network host \
    --name my-container-name \
    -e MYSQL_ROOT_PASSWORD="my-root-pass" \
    -e MYSQL_DATABASE="my_test_base" \
    -e MYSQL_USER="my_test_user" \
    -e MYSQL_PASSWORD="my_test_pass" \
    -v /etc/timezone:/etc/timezone:ro \
    -v /path/to/data/dir:/var/lib/mysql \
    -d -it vladimirok5959/mysql-server-fixed:latest
```

Host network just for example, `-v /etc/timezone:/etc/timezone:ro` for getting time zone from host machine and `-v /path/to/data/dir:/var/lib/mysql` for rebind database data directory.
