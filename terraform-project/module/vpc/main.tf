locals {
  name = var.project-name
}
# Create a custom VPC
resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "${local.name}-vpc"
  }
}
#  Create Public subnet 01
resource "aws_subnet" "pub-sn-01" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "${local.name}-pub-sub-01"
  }
}
#  Create Public subnet 02
resource "aws_subnet" "pub-sn-02" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az2
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "${local.name}-pub-sub-02"
  }
}
#  Create Private subnet 01
resource "aws_subnet" "prv-sn-01" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az1
  cidr_block        = "10.0.3.0/24"
  tags = {
    Name = "${local.name}-prv-sub-01"
  }
}
#  Create Private subnet 02
resource "aws_subnet" "prv-sn-02" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.az2
  cidr_block        = "10.0.4.0/24"
  tags = {
    Name = "${local.name}-prv-sub-01"
  }
}
# Creating internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.name}-igw"
  }
}
# Creating Elastic IP for Natgateway
resource "aws_eip" "eip" {
  domain = "vpc"
}
# Create Natgateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pub-sn-01.id
  tags = {
    Name = "${local.name}-nat-gateway"
  }
}
# Creating public route table
resource "aws_route_table" "PUB-RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.name}-pub-rt"
  }
}
# Creating private route table
resource "aws_route_table" "PRT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${local.name}-prv-rt"
  }
}
# Attaching public subnet 01 to public route table
resource "aws_route_table_association" "PUB-RT1-associated" {
  subnet_id      = aws_subnet.pub-sn-01.id
  route_table_id = aws_route_table.PUB-RT.id
}
# Attaching public subnet 02 to public route table
resource "aws_route_table_association" "PUB-RT2-associated" {
  subnet_id      = aws_subnet.pub-sn-02.id
  route_table_id = aws_route_table.PUB-RT.id
}
# Associate private subnet 01 to my private route table
resource "aws_route_table_association" "PRT1-associated" {
  subnet_id      = aws_subnet.prv-sn-01.id
  route_table_id = aws_route_table.PRT.id
}
# Associating private subnet 02 to my private route table
resource "aws_route_table_association" "PRT2-associated" {
  subnet_id      = aws_subnet.prv-sn-02.id
  route_table_id = aws_route_table.PRT.id
}

#Creating Bastion Host and Ansible security group
resource "aws_security_group" "Bastion-Ansible_SG" {
  name        = "${local.name}-Bastion-Ansible"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "Allow proxy access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.name}Bastion-Ansible-sg"
  }
}

#Creating Docker security group
resource "aws_security_group" "Docker_SG" {
  name        = "${local.name}-Docker"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "Allow ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow proxy access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.name}-Docker-sg"
  }
}
#Creating Jenkins security group
resource "aws_security_group" "Jenkins_SG" {
  name        = "${local.name}-Jenkins"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "Allow ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow proxy access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow proxy access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "Allow proxy access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.name}-Jenkins-sg"
  }
}

#Creating Sonarqube security group
resource "aws_security_group" "Sonarqube_SG" {
  name        = "${local.name}-Sonarqube"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "Allow ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow sonarqube access"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.name}Sonarqube-sg"
  }
}

#Creating Nexus security group
resource "aws_security_group" "Nexus_SG" {
  name        = "${local.name}-Nexus"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow ssh Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow nexus access"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow nexus access"
    from_port   = 8085
    to_port     = 8085
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.name}-Nexus-sg"
  }
}

#Creating MSQL RDS Database security group
resource "aws_security_group" "MYSQL_RDS_SG" {
  name        = "${local.name}-MYSQL_RDS"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description = "Allow MYSQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.Docker_SG.id]
  }

  ingress {
    description = "Allow MYSQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.Bastion-Ansible_SG.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${local.name}-MYSQL-RDS-sg"
  }
}