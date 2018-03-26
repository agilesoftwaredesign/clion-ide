# C++ development environment based on docker, ubuntu and CLion
This image provides a ubuntu desktop via VNC with a complete C++ development environment with Gnu C++, [CLion](https://www.jetbrains.com/clion/) as IDE, [googletest](https://github.com/google/googletest/) as unittest framework and [FitNesse](http://fitnesse.org/) as ATDD framework as well as some developer tools.

## Build

    ./fetch.sh && docker build -t . cppdev

## Run

    docker run --name cpp -d -P --cap-add SYS_PTRACE cppdev
    
## Use

Get to know the VNC port, check with 

    docker port cpp | grep 5901

Now you can login with you favorite VNC client application. For the initial password, take a look at ```password.txt```. As this default password is by publication not very secure anymore, consider this while working with code in your container - or change it.

## Change VNC password
You need to enter a docker image with vnc utils installed and ```vncpasswd```.

    docker run --name vnchacking -it cppdev /bin/bash

within the shell in the container, run
 
    vncpasswd

as soon as you have completed the password change process, exit the container and

    docker cp vnchacking:/root/.vnc/passwd passwd
    docker rm -f vnchacking

then rebuild the docker image.

    docker build -t . cppdev
