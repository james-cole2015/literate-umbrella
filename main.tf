module "auto-scaling" {
  source    = "./modules/auto-scaling"
  repo-name = var.repo-name
  #vpc_zone_identifier = module.networking.vpc.vpc_id
  subnet_id      = module.networking.vpc.public_subnets[0]
  security_group = [module.networking.webserver-sg.id]
  key_name       = module.key_gen.key_name
}

module "networking" {
  source    = "./modules/vpc"
  repo-name = var.repo-name
}


module "key_gen" {
  source    = "./modules/aws_keys"
  repo-name = var.repo-name
}

module "bastion-auto-scaling" {
  source    = "./modules/bastion-asg"
  repo-name = var.repo-name
  #vpc_zone_identifier = module.networking.vpc.vpc_id
  subnet_id      = module.networking.vpc.public_subnets[0]
  security_group = [module.networking.bastion-host-sg.id]
  key_name       = module.key_gen.key_name
}