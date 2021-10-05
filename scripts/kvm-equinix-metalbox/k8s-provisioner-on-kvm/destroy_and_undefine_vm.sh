for node in $(sudo virsh list --all|awk '{print $2}'|grep -v Name); do
tmp=$(sudo virsh list --all | grep " $node " | awk '{ print $3}')
if ([ "x$tmp" == "x" ] || [ "x$tmp" != "xrunning" ])
then
    echo "$node does not exist or is shut down!"
    echo "$node will be destroyed and undefined!"
    sudo virsh destroy $node
    sudo virsh undefine $node

else
    echo "$node is running!"
    echo "$node will be destroyed and undefined!"
    sudo virsh destroy $node
    sudo virsh undefine $node
fi
done
