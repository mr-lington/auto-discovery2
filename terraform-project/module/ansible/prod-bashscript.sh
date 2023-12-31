#!/bin/bash
# This script automatically update ansible host inventory
AWSBIN='/usr/local/bin/aws'
awsDiscovery() {
        \$AWSBIN ec2 describe-instances --filters Name=tag:aws:autoscaling:groupName,Values=petclinic-prod-asg \\
                --query Reservations[*].Instances[*].NetworkInterfaces[*].{PrivateIpAddresses:PrivateIpAddress} > /etc/ansible/prod-ips.list
 }
inventoryUpdate() {
        echo "[webservers]" > /etc/ansible/prod-hosts
        for instance in \`cat /etc/ansible/prod-ips.list\`
        do
                ssh-keyscan -H \$instance >> ~/.ssh/known_hosts
echo "\$instance ansible_user=ec2-user ansible_ssh_private_key_file=/etc/ansible/key.pem" >> /etc/ansible/prod-hosts
       done
}
instanceUpdate() {
  sleep 30
  ansible-playbook -i /etc/ansible/prod-hosts /etc/ansible/prod-playbook.yml --extra-var "ansible_python_interpreter=/usr/bin/python3.9"
  sleep 30
}

awsDiscovery
inventoryUpdate
instanceUpdate