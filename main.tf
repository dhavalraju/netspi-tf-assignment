module "vpc-with-ec2" {
  source            = "./modules/vpc-ec2"
  region            = var.region
  instance_type     = var.instance_type
  component         = var.component
  ami_id            = var.ami_id
  subnet_cidr_block = var.subnet_cidr_block
  public_key        = var.public_key
  bucket_name       = var.bucket_name
  public_ip         = var.public_ip
}
