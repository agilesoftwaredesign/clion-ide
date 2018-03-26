# inspired by https://github.com/queeno/docker-ubuntu-desktop
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

RUN apt-get update && \
    apt-get install --yes --no-install-recommends apt-utils ubuntu-desktop && \
    apt-get install --yes --no-install-recommends gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install --yes --no-install-recommends tightvncserver && \
    mkdir /root/.vnc
RUN apt-get install --yes --no-install-recommends vim less build-essential git curl ncurses-dev mc libboost-all-dev rsync tig default-jre-headless cmake firefox terminator doxygen graphviz lcov &&\
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

COPY xstartup /root/.vnc/xstartup
COPY passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd

# WXGA https://en.wikipedia.org/wiki/1080p#/media/File:Vector_Video_Standards2.svg
CMD /usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && tail -f /root/.vnc/*:1.log

# WQXGA https://en.wikipedia.org/wiki/1080p#/media/File:Vector_Video_Standards2.svg
#CMD /usr/bin/vncserver :1 -geometry 2560x1600 -depth 24 && tail -f /root/.vnc/*:1.log

EXPOSE 5901 80
