output "efs_dns_name" {
    value = "${module.vpc-with-ec2.efs_dns_name}"
}

output "s3_bucket_id" {
    value = "${module.vpc-with-ec2.s3_bucket_id}"
}

output "ec2_instance_id" {
    value = "${module.vpc-with-ec2.ec2_instance_id}"
}

output "security_group_id" {
    value = "${module.vpc-with-ec2.security_group_id}"
}

output "subnet_id" {
    value = "${module.vpc-with-ec2.subnet_id}"
}