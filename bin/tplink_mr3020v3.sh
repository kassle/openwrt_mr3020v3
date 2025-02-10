## build default
make image PROFILE="tplink_tl-mr3020-v3" PACKAGES="usb-modeswitch kmod-usb-net-cdc-ether kmod-usb-storage kmod-fs-ext4 blockd uhttpd uhttpd-mod-ubus libiwinfo-lua luci-base luci-app-firewall luci-mod-admin-full luci-theme-bootstrap luci-app-ksmbd luci-proto-wireguard -ppp -ppp-mod-pppoe" FILES="../files"
