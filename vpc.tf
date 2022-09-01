resource "aws_vpc" "AWS_PRIVATE_VPC" {
  cidr_block           = var.AWS_PRIVATE_VPC_CIDR
  enable_dns_support   = var.enable_dns_support_status
  enable_dns_hostnames = var.enable_dns_hostnames_status
  instance_tenancy     = var.instance_tenancy_type
  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PRIVATE_VPC_NAME}"
    Terraform        = var.isTerraformCreation
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}
resource "aws_vpc" "AWS_PUBLIC_VPC" {
  cidr_block           = var.AWS_VPC_PUBLIC_CIDR
  enable_dns_support   = var.enable_dns_support_status
  enable_dns_hostnames = var.enable_dns_hostnames_status
  instance_tenancy     = var.instance_tenancy_type
  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_NAME}"
    Terraform        = var.isTerraformCreation
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}
 
