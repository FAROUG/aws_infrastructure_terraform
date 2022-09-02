resource "aws_internet_gateway" "AWS_PUBLIC_VPC_INTERNET_GATEWAY" {
  vpc_id = aws_vpc.AWS_PUBLIC_VPC.id

  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_IG}"
    Terraform        = "true"
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}
