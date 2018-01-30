FROM queeno/ubuntu-desktop
# https://hub.docker.com/r/queeno/ubuntu-desktop/
# Using VNC to connect to the running docker container, VNC password is "password"

# install some basic tools and libraries
RUN apt-get update &&\
  apt-get install --yes --no-install-recommends vim less build-essential git curl ncurses-dev mc libboost-all-dev rsync tig default-jre-headless cmake firefox &&\
  rm -rf /var/cache/apt/

# http://fitnesse.org/fitnesse-standalone.jar?responder=releaseDownload&release=20180127
COPY fitnesse-standalone.jar /root/

## https://download-cf.jetbrains.com/cpp/CLion-2017.3.2.tar.gz
ADD CLion-2017.3.2.tar.gz /root/

RUN git clone https://github.com/google/googletest.git &&\
  cd /googletest &&\
  cmake . &&\
  make && make install &&\
  rm -rf /googletest

EXPOSE 5901