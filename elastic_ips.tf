resource "aws_eip" "AWS_PUBLIC_VPC_NAT_ELASTIC_IP" {
  vpc = true
  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_NAT_EIP_NAME}"
    Terraform        = "true"
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}
