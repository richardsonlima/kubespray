while ! ssh -oStrictHostKeyChecking=no -t -i ./id_rsa ansible@$(sudo bash ./get-vm-ip.sh node1); do echo "Checking if SSH is UP! Trying again..."; done
