# RUN ON HOST
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)
cd ../
docker compose up --build -d &&
docker exec -it yocto-build-env /bin/bash