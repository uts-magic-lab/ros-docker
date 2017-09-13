# ros-qi

Docker image with both ros and pynaoqi installed.

This is used for automatic testing and packaging.

### Development

Clone this repository (the git command below is easier, but if you don't have git you can also just [download](https://github.com/uts-magic-lab/ros-docker/archive/master.zip), unzip and then change to the ros-qi directory manually):

    git clone https://github.com/uts-magic-lab/ros-docker.git
    cd ros-docker/ros-qi

Download [`pynaoqi-python2.7-2.5.5.5-linux64.tar.gz`](https://developer.softbankrobotics.com/Software/Python/2.5.5/Linux/pynaoqi-python2.7-2.5.5.5-linux64.tar.gz) into this folder.

Build the image (you may need to run these commands with as root or Administrator or with sudo):

    docker build -t magiclab/ros-qi .

Upload the image:

    docker push magiclab/ros-qi


### Usage

- Run ros-qi docker container with

        docker run -it --name ros --rm -p 8888:8888 -p9090:9090 -p11311:11311 magiclab/ros-qi

- Navigate to [http://localhost:8888/](http://localhost:8888/) and use the password `ros`

- Run some python code, with `import qi` and `import rospy`. Open a `qi` session with the URI of a pepper or choreographe simulation.
