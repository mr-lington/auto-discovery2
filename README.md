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

<img width="813" alt="Screenshot 2023-12-19 at 03 30 55" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/806c09f0-20cd-4287-bcef-a692dfc1f112"><br>
2. ssh into the vault server<br>
3. Enter vault operator init and you will see the 5-recovery key and a token (the operator init unseal
the vault)<br>

<img width="950" alt="Screenshot 2023-12-19 at 03 37 26" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/c386557b-76a8-4b6d-ab39-9f7d57c6f375"><br>
4. vault login s. AhNKCLAZG4zPDshfpTlNt7rS<br>

<img width="951" alt="Screenshot 2023-12-19 at 03 40 37" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/02db1abe-e441-459d-b803-f69c45c99007"><br>
The above command enables you to login and start using vault server, you can even view it now from the UI<br>

<img width="952" alt="Screenshot 2023-12-19 at 03 43 24" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/3bf3a704-fb67-458b-9e07-0a323a28756f"><br>
You can now see the server status is green which means its working<br>
5. vault secrets enable -path=secrett/ kv ==== to enable our key-value (KV) secrets engine at secrett<br>

<img width="941" alt="Screenshot 2023-12-19 at 03 46 14" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/a0398613-505d-4a24-9507-798d1365cebf"><br>

<img width="952" alt="Screenshot 2023-12-19 at 03 46 59" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/5de0a8eb-e43a-459d-8d23-e58768590177"><br>
6. How we can start putting our secret credentials not to be exposed to the public<br>

<img width="969" alt="Screenshot 2023-12-19 at 03 56 21" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/37085f2c-5325-43cc-b486-fbf59218fbb1"><br>

<img width="972" alt="Screenshot 2023-12-19 at 03 57 27" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/c2cea483-8225-4fb3-ae4d-18691a6a7549"><br>
The above pictures show viewing the secrets stored in vault from UI<br>
7. To view your secret from the CLI

<img width="975" alt="Screenshot 2023-12-19 at 04 00 49" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/be55edb3-fba9-4805-b928-9b2318a64d2d"><br>
## CONNECT RDS WORK BENCH<br>
MyQSL WorkBench is integrated with the application so that we can have a vitual view of our database and also we want a database that is persistent. we deployed it in multi-az.<br>
### below are the steps to set it up<br>
1. Add your local ip address to your bastion host SG<br>

<img width="972" alt="Screenshot 2023-12-19 at 04 08 27" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/f5204b44-1e0b-46ba-8c9f-b09ad3b8faeb"><br>
2. Set up your work bench using ssh connection<br>
3. Connection method should be Standard TCP/IP over SSH and fill all the necessary vaules as shown in the image below.<br>

<img width="947" alt="Screenshot 2023-12-19 at 04 09 45" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/57aba6d6-03e3-428e-b79e-57f8120c6d09"><br>

<img width="713" alt="Screenshot 2023-12-19 at 04 13 26" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/748bba8b-c4af-47c2-afee-bf05a26f50c7"><br>
4. Create your database ( create the petclinic)<br>

<img width="777" alt="Screenshot 2023-12-19 at 04 15 07" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/dfbf9b46-a88a-4ccc-8122-12a4f00b1b8f"><br>
5. Enter user Pet-clinic to enter the petclinic<br>

<img width="778" alt="Screenshot 2023-12-19 at 04 17 07" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/164473ff-f3f7-467e-a0d8-66df989950c2"><br>
6. Create table<br>

<img width="738" alt="Screenshot 2023-12-19 at 04 17 59" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/a3ef2652-bc79-419e-bfb1-755ea6f3b004"><br>
7. Viewing the table<br>
<img width="781" alt="Screenshot 2023-12-19 at 04 19 23" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/04894f41-1c03-4d48-9dc9-3f63a2861fec"><br>
### Now connect your database to the application we want to deploy<br>
1. Go to my application.properties<br>
2. Update the datasource url with our database endpoint<br>
3. That the use name and password of our database<br>
Note : without the above step we can’t connect our database to our application
## Setting up Sonarqube<br>
1. Enter first time default username and password ADMIM<br>

<img width="726" alt="Screenshot 2023-12-19 at 04 25 22" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/e812245a-6518-42f6-97e9-c9f5c3a24408"><br>
2. Change password from the default one

<img width="736" alt="Screenshot 2023-12-19 at 04 26 27" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/c180a2d4-9a05-4046-bde4-8b15a70f485a"><br>

3. Generate sonarqube token: this token will be used as our secret text when setting up sonarqube credentials on jenkins<br>

<img width="735" alt="Screenshot 2023-12-19 at 04 33 10" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/98e28809-133b-4611-af03-fb1efc5cf301"><br>
4. create webhook

<img width="673" alt="Screenshot 2023-12-19 at 04 35 26" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/131ebfeb-9ec3-40fe-a0e9-9692bed6b9af"><br>
## Setting up nexus<br>
This is used for docker image artifactory<br>
1. Signin with admin which is the default username and CAT the path /app/sonatype-work/nexus3/admin.password on the nexus server to get default password<br>

<img width="739" alt="Screenshot 2023-12-19 at 04 43 29" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/5eabae8c-56c5-4dd1-9db1-b13b5b995569"><br>
2. choose a new password for the admin user<br>
<img width="726" alt="Screenshot 2023-12-19 at 04 44 55" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/3547d772-52b4-45ae-ad0f-b5219618a5e7"><br>

<img width="730" alt="Screenshot 2023-12-19 at 04 45 26" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/6427219c-f3ef-47ca-a6af-bc6a3745808e"><br>
3. Create docker repo in nexus: this is where we will save all our docker image to, this can be done under REPOSITORIES panel at the left top corner of UGI of nexus

<img width="730" alt="Screenshot 2023-12-19 at 04 46 31" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/63bdf76f-5001-4fdb-94fa-e1450dc899a2"><br>
Note: you can only see your image after you have built and push to the repo<br>
<img width="749" alt="Screenshot 2023-12-19 at 04 47 28" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/d04e0b40-7601-452a-8049-207636a17258"><br>
4. Go to SECURITY and the REALMS, click on DOCKER BEARER TOKEN REALM and click on the Botton next to it to move it to active on right hand panel and the SAVE<br>

<img width="721" alt="Screenshot 2023-12-19 at 04 48 46" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/ff3e2d96-47e9-4140-86ba-d83194fcde26"><br>
## Setting up Jenkins<br>
1. Set username and password for jenkins<br>
2. shh into jenkis server and cat the administrative password before you set username and password<br>
<img width="584" alt="Screenshot 2023-12-19 at 19 46 00" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/89af885d-ac2a-48c9-a39a-8198c9a131fe"><br>
<img width="606" alt="Screenshot 2023-12-19 at 19 49 29" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/74e25581-d875-40d1-978b-a7da81d19c4a"><br>

3. Install suggested plugin, install all the necessary plugins, install SLACK, SSH AGENT, MAVEN INTEGRATION and SONARQUBE SCANNER<br>

<img width="667" alt="Screenshot 2023-12-19 at 19 51 02" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/e08b3415-5b60-431b-93ee-ce94c5a1037b"><br>
<img width="674" alt="Screenshot 2023-12-19 at 19 51 31" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/5fc33c8d-1663-46f2-9252-69aab2d925a4"><br>

### configure the credentials<br>
Click on manage jenkins, click on credentials and follow the screenshoots below to configure the credentials for all the techstacks that will integrate with jenkins<br>
<img width="621" alt="Screenshot 2023-12-19 at 19 55 11" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/9173828a-63d9-45e9-96be-2dfe343671da"><br>

<img width="651" alt="Screenshot 2023-12-19 at 19 56 03" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/d8055f11-5bba-474d-a3af-00d46fa3dd8f"><br>
<img width="634" alt="Screenshot 2023-12-19 at 19 56 45" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/6d34dcbb-1b06-4d90-9ce1-62f2dc284994"><br>
<img width="625" alt="Screenshot 2023-12-19 at 19 58 12" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/c7b2a2ab-3efe-429a-a293-07d696604ac4"><br>
### Configure tools<br> 
Tools are what you install in jenkins that will integrate with jenkins<br> click on manage jenkins, click on tools<br>


<img width="649" alt="Screenshot 2023-12-19 at 20 04 24" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/35017cd2-d219-46f5-9b42-86cfa4b32b18"><br>

<img width="581" alt="Screenshot 2023-12-19 at 20 05 40" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/caa8419c-bee2-4ca5-905a-fb2fc50ec1e2"><br>
### SYSTEM Configuration<br>
This is where we configure the servers that will connect with jenkins,slack and sonarqube was configured<br>


<img width="595" alt="Screenshot 2023-12-19 at 20 08 23" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/2618d6f8-573e-468e-b3c9-6f3183859628"><br>
## CONFIGURE GITHUB WEBHOOK<br>
1. copy the API token generated in Jenkins and you it to create a webhook in github<br>
<img width="619" alt="Screenshot 2023-12-19 at 20 20 29" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/c5e13228-216b-40d6-914c-53cc1ecf338e"><br>
2. Click on SETTINGS and WEBHOOK<br>
<img width="578" alt="Screenshot 2023-12-19 at 20 22 16" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/d00e4266-2b7d-44b6-810a-4f0524466e7f"><br>
### Create Jenkins pipeline<br>

1. Enter the name you want to name the profile(PETCLINIC)<br>
<img width="556" alt="Screenshot 2023-12-19 at 20 24 29" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/5720d8c1-3830-488d-88a6-d8b23bc066b1"><br>

2. under Triggers tick GITHUB hook trigger for GITScm polling because we want or application to automatically trigger a build in our jenkins pipeline when ever there is a push to the application repository on github<br>
<img width="668" alt="Screenshot 2023-12-19 at 20 25 37" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/4939e7ec-220a-4adb-a84d-f2ffd024dd09"><br>
<img width="695" alt="Screenshot 2023-12-19 at 20 26 41" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/b607666d-0e3f-4a8c-ab27-4e29c856b71f"><br>

3. pipeline complete build trigger<br>
<img width="654" alt="Screenshot 2023-12-19 at 20 30 17" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/3573036c-b27e-4c3a-87a1-17ff882ccc42"><br>

Accessing application with stage domain name<br>
<img width="611" alt="Screenshot 2023-12-19 at 20 32 09" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/77e4b3df-96b6-410f-867a-187aa1e3bf75"><br>

Accessing application with production domain name<br>
<img width="598" alt="Screenshot 2023-12-19 at 20 33 37" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/65469815-eb4d-4063-94f1-e4e999f29758"><br>

Accessing our application with Stage and production ALB<br>
<img width="860" alt="Screenshot 2023-12-19 at 20 38 59" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/09cb18c1-caa5-444c-b812-01fc43bb721f"><br>
<img width="868" alt="Screenshot 2023-12-19 at 20 39 36" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/b9b5296d-bd1b-498b-9b53-be727d28e97b"><br>

Adding new pet to the clinic database<br>
<img width="866" alt="Screenshot 2023-12-19 at 20 44 03" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/1606354b-1934-4b21-b219-2ea73a5d1601"><br>

Now we can see that the data is persistent from our MySql workbench<br>
<img width="875" alt="Screenshot 2023-12-19 at 20 49 05" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/341b9498-3b81-46ad-9d69-4d7457416ec8"><br>

### Caring out application upgrade from github<br>
<img width="889" alt="Screenshot 2023-12-19 at 20 51 34" src="https://github.com/mr-lington/auto-discovery2/assets/99319094/089889a0-f094-4925-8db0-272da0b112ad"><br>

Original welcome.html file before application upgrade
















