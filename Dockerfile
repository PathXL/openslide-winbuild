FROM ubuntu:18.04 as base
WORKDIR /tmp

# The following are needed for configuring tzdata,
# otherwise docker build hangs.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    cmake \
    gettext \
    git \
    libglib2.0-dev \
    libtool \
    python3-pip \
    wget \
    zip

FROM base as mingw
RUN apt-get install -y \
    mingw-w64 \
    mingw-w64-tools

FROM mingw as final
RUN apt-get install -y \
    nasm \
    autoconf \
    automake \
    openjdk-8-jdk \
    ant
RUN apt-get clean

ENV ANT_HOME /usr/share/ant
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $ANT_HOME/bin:$JAVA_HOME/bin:$PATH

WORKDIR /workspace

