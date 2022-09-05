TEMP=$(mktemp)
cat > $TEMP <<EOF
network:
    version: 2
    ethernets:
        eth0:
            dhcp4: false
            addresses:
              - 10.0.$2/22
            nameservers:
              addresses:
                - 208.67.222.222
                - 208.67.220.220
            routes:
              - to: default
                via: 10.0.12.1
EOF
lxc file push $TEMP $1/etc/netplan/01-static.yaml
lxc file delete $1/etc/netplan/50-cloud-init.yaml
rm $TEMP
lxc restart $1
