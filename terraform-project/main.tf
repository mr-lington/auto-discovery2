locals {
  name = "petclinic"
}

module "vpc" {
  source       = "./module/vpc"
  project-name = local.name
  az1          = "eu-west-3a"
  az2          = "eu-west-3b"
}

module "keypair" {
  source = "./module/keypair"
}

module "load-balancer" {
  source          = "./module/load-balancer"
  stage-lb-SG     = module.vpc.docker-SG
  prod-lb-SG      = module.vpc.docker-SG
  jenkins-lb-SG   = module.vpc.jenkins-SG-ID
  vpc-id          = module.vpc.vpc-id
  subnets         = [module.vpc.prvsub1, module.vpc.prvsub2]
  certificate-arn = module.route53.petclinic-cert
  # jenkins-instance-id = module.jenkins.jenkins-id
  # subnets-id          = [module.vpc.pubsub1,module.vpc.pubsub2]
  # jenkins-SG          = module.vpc.jenkins-SG-ID
}

module "route53" {
  source              = "./module/route53"
  domain              = var.domain
  domain2             = var.domain2
  stage-domain        = var.domain-stage
  stage-lb-dns-name   = module.load-balancer.stage-lb-dns
  stage-lb-zone-id    = module.load-balancer.stage-zone-id
  prod-domain         = var.domain-prod
  prod-lb-dns-name    = module.load-balancer.prod-lb-dns
  prod-lb-zone-id     = module.load-balancer.prod-zone-id
  jenkins-domain      = var.domain-jenkins
  jenkins-lb-dns-name = module.load-balancer.jenkins-dns
  jenkins-lb-zone-id  = module.load-balancer.jenkins-zone-id
}

# module "ansible" {
#   source                = "./module/ansible"
#  ami= var.ami-redhat
#  instance-type= var.instance_type2
#  ansible-SG= module.vpc.ansible-SG-ID
#  subnet-id= module.vpc.pubsub1
#  keypair=module.keypair.out-pub-key

# }

module "bastion" {
  source        = "./module/bastion-host"
  ami           = var.ami-redhat
  instance-type = var.instance_type
  bastion-SG    = module.vpc.bastion-SG-ID
  keypair       = module.keypair.out-pub-key
  subnet-id     = module.vpc.pubsub2
}

module "jenkins" {
  source                = "./module/jenkins"
  ami                   = var.ami-redhat
  instance-type         = var.instance_type2
  keypair               = module.keypair.out-pub-key
  jenkins-SG            = module.vpc.jenkins-SG-ID
  subnet-id             = module.vpc.prvsub1
  nexus-ip              = module.nexus.nexus-ip
  newrelic-acct-id      = var.newrelic-id
  newrelic-user-licence = var.newrelic-license-key
  subnets-id            = [module.vpc.pubsub1, module.vpc.pubsub2]
}

module "nexus" {
  source                = "./module/nexus"
  ami                   = var.ami-redhat
  instance-type         = var.instance_type2
  keypair               = module.keypair.out-pub-key
  nexus-SG              = module.vpc.nexus-SG-ID
  subnet-id             = module.vpc.pubsub1
  newrelic-acct-id      = var.newrelic-id
  newrelic-user-licence = var.newrelic-license-key
}

# module "multi_az_rds" {
#   source      = "./module/rds"
#   prv-subnets = [module.vpc.prvsub1, module.vpc.prvsub1]
#   username    = data.vault_generic_secret.database.data["username"]
#   password    = data.vault_generic_secret.database.data["password"]
#   RDS-SG-ID   = [module.vpc.rds-SG-ID]
#   identifier  = var.identifier
#   db-name     = var.db-name
# }

module "sonarqube-server" {
  source        = "./module/sonarqube"
  ami           = var.ami-ubuntu
  instance-type = var.instance_type2
  subnet-id     = module.vpc.pubsub1
  sonarqube-sg  = module.vpc.sonarqube-SG-ID
  keypair       = module.keypair.out-pub-key
}

module "asg" {
  source                = "./module/asg"
  ami                   = var.ami-redhat
  instance-type         = var.instance_type2
  stage-SG-ID           = module.vpc.docker-SG
  keypair               = module.keypair.out-pub-key
  stage-asg-name        = "${local.name}-stage-asg"
  vpc-zone-identifier   = [module.vpc.prvsub1, module.vpc.prvsub1]
  tg-arn                = module.load-balancer.stage-tg-arn
  tg-arn2               = module.load-balancer.prod-tg-arn
  asg-policy            = "${local.name}-asg-policy"
  nexus-ip              = module.nexus.nexus-ip
  newrelic-acct-id      = var.newrelic-id
  newrelic-user-licence = var.newrelic-license-key
  prod-SG-ID            = module.vpc.docker-SG
  prod-asg-name         = "${local.name}-prod-asg"
}