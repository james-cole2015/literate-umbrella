module "auto-scaling" {
  source    = "./modules/auto-scaling"
  repo-name = var.repo-name
  #vpc_zone_identifier = module.networking.vpc.vpc_id
  subnet_id = module.networking.vpc.public_subnets[0]
  security_group = [module.networking.webserver-sg.id]

}

module "networking" {
  source    = "./modules/vpc"
  repo-name = var.repo-name
}