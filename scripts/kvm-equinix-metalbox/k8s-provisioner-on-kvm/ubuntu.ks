# System language
lang en_US
# Language modules to install
langsupport en_US
# System keyboard
keyboard us
# System mouse
mouse
# System timezone
timezone --utc Etc/UTC
# Root password
rootpw --disabled
# Initial user
#Welcome01 is the encrypted password. use encrypt-pw.py to generate a new one
user ansible --fullname "ansible" --iscrypted --password $6$J.QH3tHHwUf/ESXw$jS3ll.1pp79oe1cun4IjBOjjrgQrT6tqiQbMfvcOtaIdEXkeFTYXdwBpmZUaggIZCFPG83.gGiCgabYbRQ1HS1
# Reboot after installation
reboot
# Use text mode install
text
# Install OS instead of upgrade
install
# Use CDROM installation media
cdrom
# System bootloader configuration
bootloader --location=mbr 
# Clear the Master Boot Record
zerombr yes
# Partition clearing information
clearpart --all 
# Disk partitioning information
part / --fstype ext4 --size 3700 --grow
part swap --size 200 
# System authorization infomation
auth  --useshadow  --enablemd5 
# Firewall configuration
firewall --enabled --ssh 
# Do not configure the X Window System
skipx
%post --interpreter=/bin/bash
echo ### Redirect output to console
exec < /dev/tty6 > /dev/tty6
chvt 6
echo ### Update all packages
apt-get update
apt-get -y upgrade
# Install packages
apt-get install -y openssh-server vim python
echo ### Enable serial console so virsh can connect to the console
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
echo ### Add public ssh key for Ansible
mkdir -m0700 -p /home/ansible/.ssh
#use the folowing to generate a new public and private keypair: ssh-keygen -C 'ansible@host' -f id_rsa -N ''
cat <<EOF >/home/ansible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDH5D38aC/oEDsvxZSge4PTBgS1p8W/xw8DUOgUuOJOvjwb7w8W3TgJEGP0IYcaOEWbhcROq2ujhJDs6chsbcmpYn7ubfaYPzcSmSKsAYziNKIr+RsLypgWo7byt+CKE+Y40aMQ0hG+/E+2elop7zlsk/hVMjdOOmxHzUbCyC32djwi8aMXOQKcj6crCKLk0U4kqXfJQYV0OhpI539KwWS7KYMOjV2deZCxWfiQL540LU3weluQjhLzbhUdl5g7LkWTADPVxxW3pTB5a+L4ch1d4+dr5a8BUcy0k6ejYkVYmwVpbSSxbr37lAPtDYdL10R7jpJIsgz9MwYVo4dtCacVZfQhuFR0N3BBAURRNnRDNBhFtb7y1q3uiboRD7k1EW5inq/J6aZ2Xtwdv+/G5L/op9nuMKZNf/9JyKd+iyHk3jGBicQBjtQLHHPUPsc2wIbRz8tsT5GJ86j/2etWTZ+oe/RWYGN2x3NpfGSpUw7/Uyve2F8s02vUwRB9lAJEpVU= ansible@host
EOF
echo ### Set permissions for Ansible directory and key. Since the "Initial user"
echo ### is added *after* %post commands are executed, I use the UID:GID
echo ### as a hack since I know that the first user added will be 1000:1000.
chown -R 1000:1000 /home/ansible
chmod 0600 /home/ansible/.ssh/authorized_keys
# Allow Ansible to sudo w/o a password
echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
echo ### Change back to terminal 1
chvt 1

