declare -a IPS=($(for n in $(seq 1 3); do sudo ./get-vm-ip.sh node$n; done))
