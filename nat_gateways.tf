resource "aws_nat_gateway" "AWS_PUBLIC_VPC_NAT_GATEWAY" {
  allocation_id = aws_eip.AWS_PUBLIC_VPC_NAT_ELASTIC_IP.id
  subnet_id     = aws_subnet.AWS_PUBLIC_VPC_PUBLIC_SUBNET[0].id # choesen the first subnet, tried to automate it but still figuring it out, if any has solution let me know in the comments below, thanks:)
  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_NAT_NAME}"
    Terraform        = "true"
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}

data "aws_nat_gateways" "AWS_PUBLIC_VPC_NAT_GATEWAYS" {
  vpc_id = aws_vpc.AWS_PUBLIC_VPC.id
  filter {
    name   = "state"
    values = ["available"]
  }
}
data "aws_nat_gateway" "AWS_PUBLIC_VPC_NAT_GATEWAY_DATA" {
  id = aws_nat_gateway.AWS_PUBLIC_VPC_NAT_GATEWAY.id
}
output "aws_nat_gateway" {
  value = data.aws_nat_gateway.AWS_PUBLIC_VPC_NAT_GATEWAY_DATA.public_ip
}
