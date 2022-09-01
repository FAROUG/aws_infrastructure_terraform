resource "aws_vpc_peering_connection" "AWS_VPC_PERRING" {
  peer_vpc_id = aws_vpc.AWS_PUBLIC_VPC.id
  vpc_id      = aws_vpc.AWS_PRIVATE_VPC.id
  auto_accept = true

  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_VPC_PERRING_NAME}"
    Terraform        = var.isTerraformCreation
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
