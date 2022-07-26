
# EFS Security Group

resource "aws_security_group" "efs" {
  name        = "${var.component}-efs-sg"
  description = "Allow EFS inbound traffic from VPC"
  vpc_id      = aws_vpc.custom.id

  ingress {
    description      = "NFS traffic from VPC"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_groups      = ["${aws_security_group.sg.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups      = ["${aws_security_group.sg.id}"]
  }
  tags = {
    Name = "${var.component}-efs-sg"
  }
}
resource "aws_efs_file_system" "ec2" {
  creation_token = var.component

  tags = {
    Name = "${var.component}-efs"

  }
}

resource "aws_efs_mount_target" "ec2" {
  file_system_id = aws_efs_file_system.ec2.id
  subnet_id      = aws_subnet.public.id
  security_groups = ["${aws_security_group.efs.id}"]
}

