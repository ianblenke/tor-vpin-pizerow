FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y install \
	build-essential \
	gawk \
	git-core \
	libssl-dev \
	libncurses5-dev \
	lua5.1 \
	libgnutls-dev \
	libldap2-dev \
	libidn2-0-dev \
	libncurses5-dev \
	liblzma-dev \
	libssl-dev \
	libssh2-1-dev \
	libpam-dev \
	libsnmp-dev \
	libxml-parser-perl \
	mercurial \
	python-pip \
	subversion \
	time \
	wget \
	unzip \
	zlib1g-dev

#RUN git clone -b openwrt-18.06 https://git.openwrt.org/openwrt/openwrt.git
#WORKDIR openwrt

RUN git clone -b v17.01.4 https://github.com/lede-project/source.git
WORKDIR source

RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

COPY .config .config
ENV FORCE_UNSAFE_CONFIGURE=1
RUN make oldconfig

RUN make V=s -j$(nproc)

RUN sed -i \
        -e 's/# CONFIG_KERNEL_DEVMEM is not set/CONFIG_KERNEL_DEVMEM=y/' \
        -e 's/# CONFIG_KERNEL_DEVKMEM is not set/CONFIG_KERNEL_DEVKMEM=y/' \
        .config

RUN make oldconfig
RUN make V=s -j$(nproc)

RUN apt-get update
RUN apt-get install -y subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc wget unzip python curl aria2 screen ncftp time

RUN mkdir -p /imagebuilder

#RUN tar xJf ./bin/targets/brcm2708/bcm2708/lede-imagebuilder-17.01.4-brcm2708-bcm2708.Linux-x86_64.tar.xz -C /imagebuilder --strip-components 1
RUN tar xJf ./bin/targets/brcm2708/bcm2708/*-imagebuilder-*-brcm2708-bcm2708.Linux-x86_64.tar.xz -C /imagebuilder --strip-components 1
ENV PACKAGES=git-http

WORKDIR /imagebuilder

ENV PACKAGES="${PACKAGES} avahi-daemon avahi-daemon-service-ssh avahi-daemon-service-http base-files bash blkid block-mount busybox curl cryptsetup dnsmasq dropbear ca-bundle ca-certificates e2fsprogs f2fs-tools firewall fstools gcc git ip6tables iptables iw i2c-tools jshn jsonfilter kernel kmod-ath kmod-ath9k-common kmod-cfg80211 kmod-crypto-xts kmod-crypto-iv kmod-crypto-misc kmod-crypto-user kmod-fs-ext4 kmod-fs-f2fs kmod-gpio-button-hotplug kmod-i2c-algo-bit kmod-i2c-bcm2708 kmod-i2c-core kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-ledtrig-netdev kmod-lib-crc-ccitt kmod-mac80211 kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-nathelper kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc kmod-usb-acm kmod-usb-core kmod-usb2 kmod-usb-dwc2 kmod-usb-gadget-eth kmod-usb-net kmod-usb-net-cdc-ether kmod-usb-net-rndis less libblobmsg-json libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua libnl-tiny libubox libubus libubus-lua libuci libuci-lua libustream-openssl libxtables lua luci luci-app-firewall luci-app-splash luci-base luci-lib-ip luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-material luci-theme-openwrt make mtd netifd opkg ppp ppp-mod-pppoe procd python-dev python-pip python-smbus resize2fs rpcd sfdisk swconfig tcpdump tor tor-geoip uboot-envtools ubox ubus ubusd uci uhttpd uhttpd-mod-ubus usign vim wpad-mini"

RUN make image PACKAGES="${PACKAGES}"

#RUN echo src custom file:///imagebuilder/files/packages >> /imagebuilder/repositories.conf

ADD files/ files/
COPY files/target/linux/brcm2708/image/ target/linux/brcm2708/image/

RUN make image FILES=files/ PACKAGES="${PACKAGES}"

CMD sleep 1800
