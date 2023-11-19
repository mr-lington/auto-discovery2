#!/bin/bash
# update and upgrade yum packages, install yum-utils, config manager and docker
sudo yum update -y
sudo yum upgrade -y
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y

#This configuration file will allow docker communicate with nexus repo over HTTP connection
sudo cat <<EOT>> /etc/docker/daemon.json
{
  "insecure-registries" : ["${var1}:8085"]
}
EOT

#Enable and start docker engine and assign ec2-user to docker group
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

#Install New relic
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo  NEW_RELIC_API_KEY="${var2}" NEW_RELIC_ACCOUNT_ID="${var3}" NEW_RELIC_REGION=EU /usr/local/bin/newrelic install -y
sudo hostnamectl set-hostname stage-instance