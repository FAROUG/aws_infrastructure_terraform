resource "aws_route_table" "AWS_PUBLIC_VPC_ROUTE_TABLE_PUBLIC" {
  vpc_id = aws_vpc.AWS_PUBLIC_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.AWS_PUBLIC_VPC_INTERNET_GATEWAY.id
  }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #   }

  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_ROUTE_TABLE_PUBLIC_NAME}"
    Terraform        = "true"
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}

resource "aws_route_table_association" "AWS_PUBLIC_VPC_ROUTE_TABLE_PUBLIC_ASSOCIATION" {
  count          = length(aws_subnet.AWS_PUBLIC_VPC_PUBLIC_SUBNET)
  subnet_id      = aws_subnet.AWS_PUBLIC_VPC_PUBLIC_SUBNET[count.index].id
  route_table_id = aws_route_table.AWS_PUBLIC_VPC_ROUTE_TABLE_PUBLIC.id
}



resource "aws_route_table" "AWS_PUBLIC_VPC_ROUTE_TABLE_PRIVATE" {
  vpc_id = aws_vpc.AWS_PUBLIC_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    # IF you are using the count in the nat gateway resource then use the [0] 
    # nat_gateway_id = aws_nat_gateway.AWS_PUBLIC_VPC_NAT_GATEWAY[0].id
    nat_gateway_id = aws_nat_gateway.AWS_PUBLIC_VPC_NAT_GATEWAY.id
  }
  route {
    cidr_block                = aws_vpc.AWS_PRIVATE_VPC.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.AWS_VPC_PERRING.id
  }

  #   route {
  #     ipv6_cidr_block        = "::/0"
  #     egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  #   }

  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PUBLIC_VPC_ROUTE_TABLE_PRIVATE_NAME}"
    Terraform        = "true"
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}

resource "aws_route_table_association" "AWS_PUBLIC_VPC_ROUTE_TABLE_PRIVATE_ASSOCIATION" {
  count          = length(aws_subnet.AWS_PUBLIC_VPC_PRIVATE_SUBNET)
  subnet_id      = aws_subnet.AWS_PUBLIC_VPC_PRIVATE_SUBNET[count.index].id
  route_table_id = aws_route_table.AWS_PUBLIC_VPC_ROUTE_TABLE_PRIVATE.id
}

### Private VPC route Tables
resource "aws_route_table" "AWS_PRIVATE_VPC_ROUTE_TABLE" {
  vpc_id = aws_vpc.AWS_PRIVATE_VPC.id

  route {
    # cidr_block                = aws_vpc.AWS_PRIVATE_VPC.cidr_block
    cidr_block                = aws_vpc.AWS_PUBLIC_VPC.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.AWS_VPC_PERRING.id
  }

  tags = {
    Name             = "${var.Environment_NAME}-${var.Environment_TYPE}-${var.AWS_PRIVATE_VPC_ROUTE_TABLE_NAME}"
    Terraform        = "true"
    Environment_NAME = var.Environment_NAME
    Environment_TYPE = var.Environment_TYPE
  }
}

resource "aws_route_table_association" "AWS_PRIVATE_VPC_ROUTE_TABLE_ASSOCIATION" {
  count          = length(aws_subnet.AWS_PRIVATE_VPC_SUBNET)
  subnet_id      = aws_subnet.AWS_PRIVATE_VPC_SUBNET[count.index].id
  route_table_id = aws_route_table.AWS_PRIVATE_VPC_ROUTE_TABLE.id
}
