output "region" {
value = var.region
}
output "vpc_id" {
    value = aws_vpc.infra.id
}

output "project_name" {
  value = var.project_name
}

output "aws_public_subnet_az1" {
value = aws_subnet.public_subnet_az1.id
}

output "aws_public_subnet_az2" {
  value = aws_subnet.public_subnet_az2.id
}

output "aws_private_subnet_az1" {
value = aws_subnet.private_subnet_az1.id
}

output "aws_private_subnet_az2" {
    value = aws_subnet.private_subnet_az2.id
}

output "secure_subnet_az1" {
  value = aws_subnet.secure_subnet_az1.id
}
output "secure_subnet_az2" {
  value = aws_subnet.secure_subnet_az2.id
}
output "internet_gateway" {
    value = aws_internet_gateway.internet_gateway.id
}