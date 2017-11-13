FROM ubuntu:16.04 
MAINTAINER Junji Hashimoto "junji.hashimoto@gmail.com"
RUN apt-get update && \
    apt-get -y --force-yes install \
      build-essential \
      cmake \
      python2.7 \
      nodejs \
      default-jre \
      git-core \
      dh-autoreconf \
      wget \
      bison \
      flex
RUN wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz && \
    tar xfz emsdk-portable.tar.gz
RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN cd emsdk-portable && ./emsdk update
RUN cd emsdk-portable && ./emsdk install latest
RUN cd emsdk-portable && ./emsdk activate latest
#RUN cd emsdk-portable && ./emsdk construct_env

ENV PATH /emsdk-portable:/emsdk-portable/clang/e1.37.22_64bit:/emsdk-portable/node/4.1.1_64bit/bin:/emsdk-portable/emscripten/1.37.22:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV EMSDK /emsdk-portable
ENV EM_CONFIG /root/.emscripten
ENV BINARYEN_ROOT /emsdk-portable/clang/e1.37.22_64bit/binaryen
ENV EMSCRIPTEN /emsdk-portable/emscripten/1.37.22

RUN mkdir /src
WORKDIR /src
