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

<img width="813" alt="Screenshot 2023-12-19 at 03 30 55" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/806c09f0-20cd-4287-bcef-a692dfc1f112">
2. ssh into the vault server<br>
3. Enter vault operator init and you will see the 5-recovery key and a token (the operator init unseal
the vault)<br>

<img width="950" alt="Screenshot 2023-12-19 at 03 37 26" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/c386557b-76a8-4b6d-ab39-9f7d57c6f375">
4. vault login s. AhNKCLAZG4zPDshfpTlNt7rS<br>

<img width="951" alt="Screenshot 2023-12-19 at 03 40 37" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/02db1abe-e441-459d-b803-f69c45c99007">
The above command enables you to login and start using vault server, you can even view it now from the UI<br>

<img width="952" alt="Screenshot 2023-12-19 at 03 43 24" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/3bf3a704-fb67-458b-9e07-0a323a28756f">
You can now see the server status is green which means its working<br>
4. vault secrets enable -path=secrett/ kv ==== to enable our key-value (KV) secrets engine at secrett<br>
<img width="941" alt="Screenshot 2023-12-19 at 03 46 14" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/a0398613-505d-4a24-9507-798d1365cebf">

<img width="952" alt="Screenshot 2023-12-19 at 03 46 59" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/5de0a8eb-e43a-459d-8d23-e58768590177">




