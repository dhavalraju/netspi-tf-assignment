output "efs_dns_name" {
  value = aws_efs_file_system.ec2.dns_name
}
output "s3_bucket_id" {
    value = aws_s3_bucket.private.id
}

output "ec2_instance_id" {
    value = aws_instance.ec2.id
}

output "security_group_id" {
    value = aws_security_group.sg.id
}

output "subnet_id" {
    value = aws_subnet.public.id
}

