curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm
chmod +x cephadm 
./cephadm add-repo --release quincy
./cephadm install
cephadm bootstrap --mon-ip {IP}
