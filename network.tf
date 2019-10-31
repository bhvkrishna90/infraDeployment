#Cluster VPC
resource "aws_vpc" "cluster-vpc" {
  cidr_block       = "10.0.0.0/16"
  region           = "${var.aws_region}"

  tags = {
    Name = "Cluster-VPC"
  }
}
#Subnet-1
resource "aws_subnet" "subnet-1" {
  vpc_id     = "${aws_vpc.cluster-vpc.id}"
  cidr_block = "10.0.1.0/21"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.az1}"

  tags = {
    Name = "subnet-1"
  }
}
#Subnet-1
resource "aws_subnet" "subnet-2" {
  vpc_id     = "${aws_vpc.cluster-vpc.id}"
  cidr_block = "10.0.8.0/21"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.az2}"

  tags = {
    Name = "subnet-2"
  }
}
#Internet GW
resource "aws_internet_gateway" "vpcigw" {
  vpc_id = "${aws_vpc.cluster-vpc.id}"

  tags = {
    Name = "vpcigw"
  }
}
#Cluster Route Table
resource "aws_route_table" "routetable" {
  vpc_id = "${aws_vpc.cluster-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpcigw.id}"
  }
}
#Cluster VPC Security Group
resource "aws_security_group" "cluster-sg" {
  name        = "cluster-sg"
  description = "Allow ssh"
  vpc_id      = "${aws_vpc.cluster-vpc.id}"

  ingress {
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
}