# auto-discovery2
This project is the deploymet of a highly available, highly scalable, highly secure, easily upgradable and fault tolerance containerized enterprise application. This project i wrote a custom script i called auto-discovery script that will enable ansible connect into the aws console and get ip address create by asg and update this ip in the inventory host file and then go ahead and deploy application into them. because i am a big fan of automation, i make sure i wrote the my jenkins pipeline in way that limit human or no human involved in the application upgrade, this talk was done with the use of github pull trigger connect our jenkins to listen to any commit from the developer. Monitoring is also determines how robust your infrastructure will be so therefore NewRelic is use to monitor major metric the application and infrastructure.