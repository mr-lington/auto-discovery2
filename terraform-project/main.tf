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
  source              = "./module/load-balancer"
  stage-lb-SG         = module.vpc.docker-SG
  prod-lb-SG          = module.vpc.docker-SG
  vpc-id              = module.vpc.vpc-id
  subnets             = [module.vpc.prvsub1, module.vpc.prvsub2]
  certificate-arn     = module.route53.petclinic-cert
  jenkins-instance-id = module.jenkins.jenkins-id
  subnets-id          = [module.vpc.pubsub1,module.vpc.pubsub2]
  jenkins-SG          = module.vpc.jenkins-SG-ID
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

module "jenkins" {
  source       = "./module/jenkins"
ami= var.ami-redhat
instance-type=var.instance_type2
keypair= module.keypair.out-pub-key
jenkins-SG= module.vpc.jenkins-SG-ID
subnet-id= module.vpc.prvsub1
}