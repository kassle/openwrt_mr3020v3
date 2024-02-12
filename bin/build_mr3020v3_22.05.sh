## build default
make image PROFILE="tplink_tl-mr3020-v3" PACKAGES="usb-modeswitch kmod-usb-net-cdc-ether kmod-usb-storage kmod-fs-ext4 blockd openvpn-mbedtls curl uhttpd uhttpd-mod-ubus libiwinfo-lua luci-base luci-app-firewall luci-mod-admin-full luci-theme-bootstrap luci-app-ksmbd luci-app-openvpn luci-app-ddns luci-app-https-dns-proxy -ppp -ppp-mod-pppoe" FILES="files"

## max - has issue can't save config
# make image PROFILE="tplink_tl-mr3020-v3" PACKAGES="usb-modeswitch kmod-usb-net-cdc-ether kmod-usb-storage kmod-fs-ext4 blockd ethtool openvpn-mbedtls ip6tables-mod-nat kmod-ipt-nat6 uhttpd uhttpd-mod-ubus libiwinfo-lua luci-base luci-app-firewall luci-mod-admin-full luci-theme-bootstrap luci-app-ksmbd luci-app-https-dns-proxy luci-app-adblock-fast luci-app-openvpn gawk grep sed coreutils-sort -ppp -ppp-mod-pppoe -opkg" FILES="files"
