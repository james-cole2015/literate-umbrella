module "auto-scaling" {
    source = ./modules/auto-scaling
    repo-name = var.repo-name
}