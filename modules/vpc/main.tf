data "aws_availability_zones" "available" {}

module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  name                         = var.vpc_name
  cidr                         = var.cidr_block
  azs                          = data.aws_availability_zones.available.names
  private_subnets              = var.private_sn
  public_subnets               = var.public_sn
  create_database_subnet_group = true
  #enable_nat_gateway           = true
  single_nat_gateway = true


}