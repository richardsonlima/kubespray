for node in $(sudo virsh list --all|awk '{print $2}'|grep -v Name); do
tmp=$(sudo virsh list --all | grep " $node " | awk '{ print $3}')
if ([ "x$tmp" == "x" ] || [ "x$tmp" != "xrunning" ])
then
    echo "$node does not exist or is shut down!"
    sudo virsh start $node
else
    echo "$node is running!"
fi
done
