# auto-discovery2
This project is the deploymet of a highly available, highly scalable, highly secure, easily upgradable and fault tolerance containerized enterprise application. this project i call ANSIBLE AUTO DISCOVERY because of the custom ansible script i called auto-discovery script that will enable ansible connect into the aws console and get ip address create by asg and update this ip in the inventory host file and then go ahead and deploy application into them. because i am a big fan of automation, i make sure i wrote the my jenkins pipeline in way that limit human or no human involved in the application upgrade, this talk was done with the use of github pull trigger connect our jenkins to listen to any commit from the developer. Monitoring is also determines how robust your infrastructure will be so therefore NewRelic is use to monitor major metric the application and infrastructure.

## Built with
Maven

## Prerequisites
 <p>1. First you have to install aws cli on your local machine.<br>
 2. Secord you need a linux machine.<br>

## Tech-Stack
docker<br>
jenkins<br>
terraform<br>
ansible<br>
sonarqube<br>
nexus<br>
hashicorp vault<br>
new relic<br>
MySQL Workbench<br>

## ARCHITECTURAL DIAGRAM<br>
this architectural diagram gives an overview of the infrastructure and all of the techstack used.

<img width="1121" alt="Screenshot 2023-12-19 at 03 13 18" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/5c1896f6-f99c-4a91-8adb-934c545e29cd">

## SETTING UP THE INFRASTRUCTURE<br>
### NOTE: this project is deployed using the terraform tfvars that is not included in this project, if you want it, you can request for it by messaging me on linkedin like i will put at the end of this project
## Vault set up<br>
1. Terraform init and terraform apply -var-file vault.tfvars -auto-approve<br>



