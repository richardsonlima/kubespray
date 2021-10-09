for node in $(sudo virsh list --all|awk '{print $2}'|grep -v Name); do
tmp=$(sudo virsh list --all | grep " $node " | awk '{ print $3}')
if ([ "x$tmp" == "x" ] || [ "x$tmp" != "xrunning" ])
then
    echo "$node does not exist or is shut down!"
    sudo bash -x ./check_and_start_vm.sh && sleep 60
    while ! ssh -oStrictHostKeyChecking=no -t -i ./id_rsa ansible@$(sudo bash ./get-vm-ip.sh $node); do echo "Checking if SSH is UP! Trying again..."; done
else
    echo "$node is running!"
    echo "$node Checking if SSH is UP!"
    while ! ssh -oStrictHostKeyChecking=no -t -i ./id_rsa ansible@$(sudo bash ./get-vm-ip.sh $node); do echo "Checking if SSH is UP! Trying again..."; done
fi
done
