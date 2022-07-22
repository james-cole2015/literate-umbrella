module "auto-scaling" {
  source    = "./modules/auto-scaling"
  repo-name = var.repo-name
}

module "networking" {
  source    = "./modules/vpc"
  repo-name = var.repo-name
}