data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}
output "aws_region" {
  value = data.aws_region.current.name
}
output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

# ..... Remove it once it worked in output.tf
# output "PUBLIC_VPC_SECURITY_GROUPS_OUTPUT" {
#   value = var.PUBLIC_VPC_SECURITY_GROUPS
# }
# output "PRIVATE_VPC_SECURITY_GROUPS_OUTPUT" {
#   value = var.PRIVATE_VPC_SECURITY_GROUPS
# }


resource "aws_subnet" "AWS_PRIVATE_VPC_SUBNET" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.AWS_PRIVATE_VPC.id
  cidr_block              = cidrsubnet(aws_vpc.AWS_PRIVATE_VPC.cidr_block, 8, count.index * 16)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name             = format("%s-%s", "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PRIVATE_VPC_SUBNETS_NAME}", data.aws_availability_zones.available.names[count.index])
    Terraform        = var.isTerraformCreation
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}

resource "aws_subnet" "AWS_PUBLIC_VPC_PUBLIC_SUBNET" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.AWS_PUBLIC_VPC.id
  cidr_block              = cidrsubnet(aws_vpc.AWS_PUBLIC_VPC.cidr_block, 8, count.index * 16)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name             = format("%s-%s", "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_PUBLIC_SUBNETS_NAME}", data.aws_availability_zones.available.names[count.index])
    Terraform        = var.isTerraformCreation
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}

resource "aws_subnet" "AWS_PUBLIC_VPC_PRIVATE_SUBNET" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.AWS_PUBLIC_VPC.id
  cidr_block              = cidrsubnet(aws_vpc.AWS_PUBLIC_VPC.cidr_block, 8, (count.index * 16) + 8)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name             = format("%s-%s", "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_PRIVATE_SUBNETS_NAME}", data.aws_availability_zones.available.names[count.index])
    Terraform        = var.isTerraformCreation
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}
