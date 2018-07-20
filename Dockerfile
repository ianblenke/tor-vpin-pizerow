FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y install git-core build-essential libssl-dev libncurses5-dev unzip lua5.1 libxml-parser-perl subversion

RUN git clone -b openwrt-18.06 https://git.openwrt.org/openwrt/openwrt.git
WORKDIR openwrt

RUN apt-get install -y gawk wget time python-pip

COPY .config .config
ENV FORCE_UNSAFE_CONFIGURE=1
RUN make oldconfig
RUN make V=s
