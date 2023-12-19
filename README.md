# auto-discovery2
This project is the deploymet of a highly available, highly scalable, highly secure, easily upgradable and fault tolerance containerized enterprise application. this project i call ANSIBLE AUTO DISCOVERY because of the custom ansible script i called auto-discovery script that will enable ansible connect into the aws console and get ip address create by asg and update this ip in the inventory host file and then go ahead and deploy application into them. because i am a big fan of automation, i make sure i wrote the my jenkins pipeline in way that limit human or no human involved in the application upgrade, this talk was done with the use of github pull trigger connect our jenkins to listen to any commit from the developer. Monitoring is also determines how robust your infrastructure will be so therefore NewRelic is use to monitor major metric the application and infrastructure.

## Built with
Maven

## prerequisites
 <p>1. First you have to install aws cli on your local machine.<br>
 2. Secord you need a linux machine.

tech-stack
docker
jenkins
terraform
ansible
sonarqube
nexus
hashicorp vault
new relic
MySQL Workbench

ARCHITECTURAL DIAGRAM 
this architectural diagram gives an overview of the infrastructure and all of the techstack used.

<img width="943" alt="lington-auto-discovery" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/a5365d40-35f2-4879-8719-c5b04cfd6164">
