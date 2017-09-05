# ros-pal

### How to build this docker image

- Add `cobalt.tar.gz` to this folder.

- run `docker build -t ros-pal .`

### How to use the image

- Navigate to `chip_ws`

- run `docker run --rm -it --name=ros -v $PWD:/home/rosuser/chip_ws -p 11311:11311 -p 9090:9090 ros-pal`

- run ros apps in the main shell

- attach a new shell with `docker exec -it ros bash -l`
