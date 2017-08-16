# ros-qi

Docker image with both ros and pynaoqi installed.

This is used for automatic testing and packaging.

### Development

Download `pynaoqi-python2.7-2.5.5.5-linux64.tar.gz` into this folder.

Build the image:

    docker build -t magiclab/ros-qi .

Upload the image:

    docker push magiclab/ros-qi


### Usage

- run choreographe on host computer and get virtual robot port number
- run ros-qi docker container with that port number 
- run some python file inside docker container, with "import qi" and "import rospy"
