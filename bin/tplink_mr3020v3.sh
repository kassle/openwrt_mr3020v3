## openwrt
if [ -z "$OPENWRT_VERSION" ]; then
    OPENWRT_VERSION="24.10.2"
fi

OPENWRT_BUILDER="https://downloads.openwrt.org/releases/$OPENWRT_VERSION/targets/ramips/mt76x8/openwrt-imagebuilder-$OPENWRT_VERSION-ramips-mt76x8.Linux-x86_64.tar.zst"
OPENWRT_WORKDIR="openwrt-imagebuilder-$OPENWRT_VERSION-ramips-mt76x8.Linux-x86_64"

## download builder
BUILDER="builder.tar.zst"
rm $BUILDER
wget -O $BUILDER "$OPENWRT_BUILDER"

if [ ! -s "$BUILDER" ]; then
    echo "Failed to download $OPENWRT_BUILDER"
fi

tar xvf $BUILDER

if [ ! -d "$OPENWRT_WORKDIR" ]; then
    echo "Failed to extract builder. it may corrupted or format changed"
fi

## build image
cd $OPENWRT_WORKDIR
make image PROFILE="tplink_tl-mr3020-v3" PACKAGES="usb-modeswitch kmod-usb-net-cdc-ether kmod-usb-storage kmod-fs-ext4 blockd uhttpd uhttpd-mod-ubus libiwinfo-lua luci-base luci-app-firewall luci-mod-admin-full luci-theme-bootstrap luci-app-ksmbd luci-proto-wireguard -ppp -ppp-mod-pppoe" FILES="../files"

BIN1="bin/targets/ramips/mt76x8/openwrt-${OPENWRT_VERSION}-ramips-mt76x8-tplink_tl-mr3020-v3-squashfs-sysupgrade.bin"
if [ -f "$BIN1" ]; then
    mv -v $BIN1 ../tplink-mr3020v3_${OPENWRT_VERSION}_sysupgrade.bin
fi

BIN2="bin/targets/ramips/mt76x8/openwrt-${OPENWRT_VERSION}-ramips-mt76x8-tplink_tl-mr3020-v3-squashfs-tftp-recovery.bin"
if [ -f "$BIN2" ]; then
    mv -v $BIN2 ../tplink-mr3020v3_${OPENWRT_VERSION}_recovery.bin
fi
