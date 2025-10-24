## openwrt
if [ -z "$OPENWRT_VERSION" ]; then
    OPENWRT_VERSION="24.10.4"
fi

OPENWRT_BASEURL="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/ramips/mt7621"
OPENWRT_BUILDER=`curl -sL $OPENWRT_BASEURL | grep "openwrt-imagebuilder-$OPENWRT_VERSION-ramips-mt7621.Linux-x86_64" | awk -F\" '{ print $4 }'`
OPENWRT_BUILDER="$OPENWRT_BASEURL/$OPENWRT_BUILDER"
OPENWRT_WORKDIR="openwrt-imagebuilder-$OPENWRT_VERSION-ramips-mt7621.Linux-x86_64"

## download builder
BUILDER="builder.tar.zst"
# rm $BUILDER
# curl -s "$OPENWRT_BUILDER" -o $BUILDER

if [ ! -s "$BUILDER" ]; then
    echo "Failed to download $OPENWRT_BUILDER"
fi

tar xvf $BUILDER

if [ ! -d "$OPENWRT_WORKDIR" ]; then
    echo "Failed to extract builder. it may corrupted or format changed"
fi

## build image
cd $OPENWRT_WORKDIR
make image PROFILE="asus_rt-ax53u" PACKAGES="usb-modeswitch kmod-usb-net-cdc-ether kmod-usb-storage kmod-fs-ext4 blockd luci-nginx luci-ssl-nginx libiwinfo-lua luci-base luci-proto-wireguard luci-proto-ipv6 luci-mod-admin-full luci-theme-bootstrap luci-app-acme luci-app-firewall luci-app-ksmbd luci-app-wol -ppp -ppp-mod-pppoe" FILES="../files/files_asus-ax53u"

BIN1="bin/targets/ramips/mt7621/openwrt-${OPENWRT_VERSION}-ramips-mt7621-asus_rt-ax53u-squashfs-sysupgrade.bin"
if [ -f "$BIN1" ]; then
    mv -v $BIN1 ../asus-ax53u_${OPENWRT_VERSION}_sysupgrade.bin
fi

BIN2="bin/targets/ramips/mt7621/openwrt-${OPENWRT_VERSION}-ramips-mt7621-asus_rt-ax53u-squashfs-factory.bin"
if [ -f "$BIN2" ]; then
    mv -v $BIN2 ../asus-ax53u_${OPENWRT_VERSION}_factory.bin
fi
