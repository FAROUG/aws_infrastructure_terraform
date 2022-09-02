### Initial 
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_SWITCH_ROLE" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
# ================================================================================================================================================
### General Tags that will be used accross this terraform 
variable "Environment_NAME" {
  default = "example-app"
}
variable "Environment_TYPE" {
  default = "prod"
}
variable "isTerraformCreation" {
  default = "true"
}
# ================================================================================================================================================
### VPC Section
variable "enable_dns_support_status" {
  default = true
}
variable "enable_dns_hostnames_status" {
  default = true
}
variable "instance_tenancy_type" {
  default = "default"
}
variable "AWS_PRIVATE_VPC_NAME" {
  default = "private-vpc"
}
variable "AWS_PRIVATE_VPC_CIDR" {
  default = "10.0.0.0/16"
}
variable "AWS_PUBLIC_VPC_NAME" {
  default = "public-vpc"
}
variable "AWS_VPC_PUBLIC_CIDR" {
  default = "173.31.0.0/16"
}
# ------------------------------------------------------------------------
## Peering
variable "AWS_VPC_PERRING_NAME" {
  default = "vpc-peering"
}
# ------------------------------------------------------------------------
## Subnets
variable "AWS_PRIVATE_VPC_SUBNETS_NAME" {
  default = "private-vpc"
}
variable "AWS_PUBLIC_VPC_PUBLIC_SUBNETS_NAME" {
  default = "public-vpc-public"
}
variable "AWS_PUBLIC_VPC_PRIVATE_SUBNETS_NAME" {
  default = "public-vpc-private"
}
# ------------------------------------------------------------------------
## Internet Gateway
variable "AWS_PUBLIC_VPC_IG" {
  default = "public-vpc-internet-gateway"
}
# ------------------------------------------------------------------------
## NAT Gateway

# ELP
variable "AWS_PUBLIC_VPC_NAT_EIP_NAME" {
  default = "public-vpc-nat-ip"
}
# -------------------------------------
# NAT
variable "AWS_PUBLIC_VPC_NAT_NAME" {
  default = "public-vpc-nat"
}
# ------------------------------------------------------------------------
## Route Table
variable "AWS_PUBLIC_VPC_ROUTE_TABLE_PUBLIC_NAME" {
  default = "public-vpc-route-table-public"
}
variable "AWS_PUBLIC_VPC_ROUTE_TABLE_PRIVATE_NAME" {
  default = "public-vpc-route-table-private"
}
variable "AWS_PRIVATE_VPC_ROUTE_TABLE_NAME" {
  default= "private-vpc-route-table"
}
# ================================================================================================================================================
### S3
variable "AWS_RESOURCE_BUCKET_NAME" {
  default = "s3-resource-bucket"
}
variable "AWS_SECURITY_GROUP_DESCRIPTION" {
  default = "Allow the access to the private server"
}
variable "BASH_SCRIPTS_FOLDER_PATH" {
  default = "bash-scripts"
}
variable "BASH_SCRIPTS_ZIP_FILE" {
  default = "my_ssh_files.zip"
}
## is to allow to change the name while been uploaded to s3
variable "AWS_SSH_ZIP_FILE_NAME" {
  default = "my_ssh_files.zip"
}
# ================================================================================================================================================
### IAM

## IAM Policy
variable "AWS_IAM_POLICY_EC2_CUSTOMIZED_NAME" {
  default = "ec2-customized-policy"
}
# ------------------------------------------------------------------------
## IAM Role
variable "AWS_IAM_ROLE_EC2_NAME" {
  default = "EC2InstanceRole"
}