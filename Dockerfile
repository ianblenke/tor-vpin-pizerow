FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc wget unzip python curl aria2 screen ncftp

RUN mkdir -p /imagebuilder
RUN curl -sL https://downloads.lede-project.org/releases/17.01.5/targets/brcm2708/bcm2708/lede-imagebuilder-17.01.5-brcm2708-bcm2708.Linux-x86_64.tar.xz | tar xJf - -C /imagebuilder --strip-components 1

WORKDIR /imagebuilder

ENV PACKAGES="avahi-daemon avahi-daemon-service-ssh avahi-daemon-service-http base-files busybox dnsmasq dropbear e2fsprogs firewall fstools hostapd-common ip6tables iptables iw jshn jsonfilter kernel kmod-ath kmod-ath9k-common kmod-cfg80211 kmod-gpio-button-hotplug kmod-ip6tables kmod-ipt-conntrack kmod-ipt-core kmod-ipt-nat kmod-lib-crc-ccitt kmod-mac80211 kmod-nf-conntrack kmod-nf-conntrack6 kmod-nf-ipt kmod-nf-ipt6 kmod-nf-nat kmod-nf-nathelper kmod-nls-base kmod-ppp kmod-pppoe kmod-pppox kmod-slhc kmod-usb-acm kmod-usb-core kmod-usb2 kmod-usb-dwc2 kmod-usb-gadget-eth kmod-usb-serial-option kmod-usb-net kmod-usb-net-cdc-ether kmod-usb-net-rndis libblobmsg-json libc libgcc libip4tc libip6tc libiwinfo libiwinfo-lua libjson-c libjson-script liblua libnl-tiny libubox libubus libubus-lua libuci libuci-lua libxtables lua luci luci-app-firewall luci-base luci-lib-ip luci-lib-nixio luci-mod-admin-full luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap luci-theme-material luci-theme-openwrt mtd netifd odhcp6c odhcpd opkg ppp ppp-mod-pppoe procd rpcd swconfig tor tor-geoip uboot-envtools ubox ubus ubusd uci uhttpd uhttpd-mod-ubus usign wpad-mini"

RUN make image PACKAGES="${PACKAGES}"

#RUN echo src custom file:///imagebuilder/files/packages >> /imagebuilder/repositories.conf

ADD files/ files/

RUN make image FILES=files/ PACKAGES="${PACKAGES}"

CMD sleep 1800
