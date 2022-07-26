resource "aws_vpc" "custom" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.component}-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.custom.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.component}"
  }
}


resource "aws_security_group" "sg" {
  name        = "${var.component}-sg"
  description = "Allow inbound http traffic"
  vpc_id      = aws_vpc.custom.id

  ingress {
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
}


resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "${var.component}-gateway"
  }

}

resource "aws_route_table" "routetable" {
  vpc_id     = aws_vpc.custom.id
  depends_on = [aws_subnet.public]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.component}-routes"
  }
}

resource "aws_route_table_association" "routetable_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.routetable.id
  depends_on     = [aws_subnet.public]
}

resource "aws_key_pair" "instance_key" {
  key_name   = "${var.component}-key"
  public_key = var.public_key
}




