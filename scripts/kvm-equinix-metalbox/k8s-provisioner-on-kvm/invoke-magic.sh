export CONFIG_FILE=/home/jenkins/var/jenkins_home/workspace/pipeline-only-for-debug/inventory/mycluster/hosts.yml
declare -a IPS=($(for n in $(seq 1 3); do sudo ./get-vm-ip.sh node$n; done))
#echo ${IPS[@]}
python3 ./inventory.py ${IPS[@]}
