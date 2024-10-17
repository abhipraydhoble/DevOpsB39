module "vpc" {
    source = "./vpc"
    vpc_cidr_block = var.vpc_cidr_block
    aws_subnet = var.aws_subnet
    az = var.az
    public_ip = var.public_ip
    port_no = var.port_no
}







module "ec2" {
    source = "./ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    key = var.key
}
