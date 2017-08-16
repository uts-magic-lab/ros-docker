# ros-qi

Docker image with both ros and pynaoqi installed.

This is used for automatic testing and packaging.

### Development

Download `pynaoqi-python2.7-2.5.5.5-linux64.tar.gz` into this folder.

Build the image:

    docker build -t magiclab/ros-qi .

Upload the image:

    docker push magiclab/ros-qi
