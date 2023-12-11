locals {
  sonarqube_user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo docker run -it -d --name sonarqube -p 9000:9000 sonarqube
curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo  NEW_RELIC_API_KEY=NRAK-10JJG9JWDCXPX0P4DY6RIMBSFTH NEW_RELIC_ACCOUNT_ID=3946372 NEW_RELIC_REGION=EU /usr/local/bin/newrelic install -y
sudo hostnamectl set-hostname sonarqube
EOF
}