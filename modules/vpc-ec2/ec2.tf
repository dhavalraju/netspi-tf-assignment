data "aws_eip" "ip" {
  public_ip = var.public_ip
}
data "template_file" "init" {
  template = file("${path.module}/script-init.sh.tpl")
  vars = {
    efs_dns_name = aws_efs_file_system.ec2.dns_name
  }

}
resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.instance_key.key_name
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  subnet_id              = aws_subnet.public.id
  iam_instance_profile   = aws_iam_instance_profile.profile.name
  tags = {
    Name = "${var.component}-instance"
  }

  user_data = data.template_file.init.rendered
}

resource "aws_eip_association" "ip" {
  instance_id   = aws_instance.ec2.id
  allocation_id = data.aws_eip.ip.id
}