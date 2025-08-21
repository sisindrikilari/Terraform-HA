# create a VPC 
resource "aws_vpc" "infra" {
 cidr_block = var.vpc_cidr
 enable_dns_hostnames = true
 instance_tenancy = "deafault"

 tags= {
    Name = "${var.project_name}-vpc"
 } 
}
# create a internet gateway 
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.infra.id
  
  tags = {
    Name = "${var.project_name}-igw"
  }
}

 # pull the avialability Zones 
data "aws_avaialability_zones" "availability_zones" {}
# create public subnets in az1"
resource "aws_subnet" "public_subnet_az1" {
  vpc_id = aws_vpc.infra.id
  cidr_block = var.public_subnet_az1_cidr
  availability_zone = data.aws_avaialability_zones.availability_zones.names[0]
  map_public_ip_on_launch = true

  tags= {
    Name = "public-subnet-az1"
  }
}
# create a public subnet az2 

resource "aws_subnet" "public_subnet_az2" {
  vpc_id = aws_vpc.infra.id
  cidr_block = var.public_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = true

  tags= {
    Name = "public-subnet-az2"
  }
}
# careate a route table for public subnets allow igw 
resource "aws_route_table" "public_route_table" {
vpc_id = aws_vpc.infra.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id

   }
   tags = {
    Name = "public-route-table"
   }
}
# route table association for public subnet az1
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
subnet_id = aws_subnet.public_subnet_az1.id
route_table_id = aws_route_table.public_route_table.id
}
# route table association for public subnet az2
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
subnet_id = aws_subnet.public_subnet_az2.id
route_table_id = aws_route_table.public_route_table.id
}

# create a private subnet Az1

resource "aws_subnet" "private_subnet_az1" {
  vpc_id = aws_vpc.infra.id
  cidr_block = var.private_subnet_az1_cidr
  availability_zone = data.aws_availability_zones.avilability_zones.names[0]
   map_public_ip_on_launch = false 
tags = {
    Name = "private -subnet-az1"
}
}
# create a private subnet Az2
resource "aws_subnet" "private_subnet_az2" {
  vpc_id = aws_vpc.infra.id
  cidr_block = var.private_subnet_az2_cidr
  availability_zone = data.aws_availability_zones.avilability_zones.names[1]
   map_public_ip_on_launch = false 
tags = {
    Name = "private -subnet-az2"
}
}
# create secure subnet Az1
resource "aws_subnet" "secure_subnet_az1" {
    vpc_id = aws_vpc.infra.id
    cidr_block = var.secure_subnet_az1_cidr
availability_zone = data.aws_availability_zones.availability_zones.names[0]
map_public_ip_on_launch = false
tags = {
    Name = "secure-subnet-az1"
}
}
# crate secure subnet az2
resource "aws_subnet" "secure_subnet_az2" {
    vpc_id = aws_vpc.infra.id
    cidr_block = var.secure_subnet_az2_cidr
availability_zone = data.aws_availability_zones.availability_zones.names[1]
map_public_ip_on_launch = false
tags = {
    Name = "secure-subnet-az2"
}
}




