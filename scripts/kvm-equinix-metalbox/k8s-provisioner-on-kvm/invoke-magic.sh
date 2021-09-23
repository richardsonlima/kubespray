export CONFIG_FILE=/home/jenkins/var/jenkins_home/workspace/baremetal-create-k8s-cluster/inventory/mycluster/hosts.yml
declare -a IPS=($(for n in $(seq 1 3); do sudo ./get-vm-ip.sh node$n; done))
#echo ${IPS[@]}
python3 /home/jenkins/var/jenkins_home/workspace/baremetal-create-k8s-cluster/contrib/inventory_builder/inventory.py ${IPS[@]}
