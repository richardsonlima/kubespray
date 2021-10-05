export LIBVIRT_DEFAULT_URI="qemu:///system"
for n in $(seq 1 3); do
    ./create-vm.sh -n node$n \
      -i 'http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/' \
      -k ./ubuntu.ks \
      -r 2048 \
      -c 8 \
      -s 15
done
